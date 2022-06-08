Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE66CCCA481
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiFHTHh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiFHTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:07:29 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DAD3FDAB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:06:07 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id z10FnxNJJOOQ1z10FnBYWW; Wed, 08 Jun 2022 21:06:05 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 08 Jun 2022 21:06:05 +0200
X-ME-IP: 90.11.190.129
Message-ID: <66584227-9688-b738-1300-4b379ea0689c@wanadoo.fr>
Date:   Wed, 8 Jun 2022 21:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] virtio: Directly use ida_alloc_range()/ida_free()
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608060826.1681-1-wangdeming@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220608060826.1681-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 08/06/2022 à 08:08, Deming Wang a écrit :
> Use ida_alloc_range()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>   drivers/vhost/vdpa.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 935a1d0ddb97..384049cfca8d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1293,7 +1293,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>   	struct vhost_vdpa *v =
>   	       container_of(device, struct vhost_vdpa, dev);
>   
> -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> +	ida_free(&vhost_vdpa_ida, v->minor);
>   	kfree(v->vqs);
>   	kfree(v);
>   }
> @@ -1316,8 +1316,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>   	if (!v)
>   		return -ENOMEM;
>   
> -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> +	minor = ida_alloc_range(&vhost_vdpa_ida, 0, VHOST_VDPA_DEV_MAX - 1, GFP_KERNEL);

ida_alloc_max() would be better here. It is less verbose.

An explanation in the commit log of why the -1 is needed would also help 
reviewer/maintainer, IMHO.

It IS correct, but it is not that obvious without looking at 
ida_simple_get() and ida_alloc_range().

CJ


>   	if (minor < 0) {
>   		kfree(v);
>   		return minor;

