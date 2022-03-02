Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA37C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 13:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiCBNbv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 08:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiCBNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C58AAC4E3B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646227860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpr93uN6MxOxe9fXO/50h3J2w847QD18h7MxHrR4EFI=;
        b=NGQm8ZbhFRxrUVDBZXxx3n+z53fJ+MJAZPwIHtTZmFNxd2vViZhac9+4GPDuRx1kcxEwX/
        YVdqbNbJn5beFo15ALgpMDguTSNnBCT7OCq5aA+q0VQKCqZMXCMzg4kgMM5LBYNo8CWDbl
        4T1pxBFFJe/nd8nuPWcyV5AIrpI1sRI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-W1Tnvd8TNo63aMFbWzX46g-1; Wed, 02 Mar 2022 08:30:59 -0500
X-MC-Unique: W1Tnvd8TNo63aMFbWzX46g-1
Received: by mail-wm1-f71.google.com with SMTP id v125-20020a1cac83000000b0037e3d70e7e1so1944924wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpr93uN6MxOxe9fXO/50h3J2w847QD18h7MxHrR4EFI=;
        b=oQBm9mKh1FMxmrv4rGf5gPc46Ic8KUDjIX+MwwbmZbPgbkPW03TDP3DNJcg1Wp0GfF
         ZrZekEjCCN2OtZmZ2uJmlDCVwZWUTBdCM8y2l+vcxo1cgQT4MndpG2aLvTHP6Lnv96so
         HqSON8lA8RnGrt0Do50sxSz5NgXZqkkfHskHQbzoigb+IUOEDBN4rnI9iRl1CHncEuHS
         KcC2gzxmvx+hLcRVrIwISeIKHbLRYdHv283WPbOSQVqgdqp/XZ5KmYiciEUarxGrdLD8
         u6jj62GO3bUyZuCGTpM5Awux5JTF02P2UmjXnJ9Uh6GuCU45QFmPvXphMB+SEuZFBb4r
         307w==
X-Gm-Message-State: AOAM531MmtGYW6GlhrktLtEDt0ubcnZI+gfkNPEBW6XIshPaEZdqqel4
        Mwas4QvrqbL69j4s+ytwTOb/GN6sSH8OzE8n1CtJ8FPIznY/fpq9viI3m/1VW+rn5tjdAXKRYcJ
        sglli+QA9Xxu13xtmiwe9Sll9
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id o9-20020a5d4089000000b001f0481961bamr706809wrp.307.1646227857898;
        Wed, 02 Mar 2022 05:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB5w9pGnsT+Lg3Clzc3lJA6rrR//BxxGl8wdCoogL6jR5Pnb1QZrgmJ3q8QCWDn1myvFVNdQ==
X-Received: by 2002:a5d:4089:0:b0:1f0:4819:61ba with SMTP id o9-20020a5d4089000000b001f0481961bamr706789wrp.307.1646227857681;
        Wed, 02 Mar 2022 05:30:57 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05600c3d8600b00381590dbb25sm9721486wmb.3.2022.03.02.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:30:56 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:30:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220302082021-mutt-send-email-mst@kernel.org>
References: <20220302075421.2131221-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302075421.2131221-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 07:54:21AM +0000, Lee Jones wrote:
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
> 
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..bbaff6a5e21b8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> +		mutex_lock(&dev->vqs[i]->mutex);
>  		if (dev->vqs[i]->error_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
>  		if (dev->vqs[i]->kick)
> @@ -700,6 +701,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		if (dev->vqs[i]->call_ctx.ctx)
>  			eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>  		vhost_vq_reset(dev, dev->vqs[i]);
> +		mutex_unlock(&dev->vqs[i]->mutex);
>  	}

So this is a mitigation plan but the bug is still there though
we don't know exactly what it is.  I would prefer adding something like
WARN_ON(mutex_is_locked(vqs[i]->mutex) here - does this make sense?



>  	vhost_dev_free_iovecs(dev);
>  	if (dev->log_ctx)
> -- 
> 2.35.1.574.g5d30c73bfb-goog

