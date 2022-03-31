Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 11:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiCaLYj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiCaLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235D3206EE2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648725770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNP1A1QI6ELQhIr06lqyOR8+E3R+/itvgmLbp3dg+co=;
        b=d975+l6+sZ8md30KkZiftaWZO+LKIrWyIWQAJRpyrpa7OJSDZ3jD2af/k6SCnEeI7nEo2k
        F6CYuOG1Fxo8qLzFoTiyVz8IquL5wAuz3HVgh/89nXd8skG11pPHdY6+GQqoiM4NW6cc4q
        zJAZ3GpBu22K4g2WeTzmXEBiUIrIe4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-okBLcBc1ODKjgqyhnc311A-1; Thu, 31 Mar 2022 07:22:48 -0400
X-MC-Unique: okBLcBc1ODKjgqyhnc311A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2ABE85A5BE;
        Thu, 31 Mar 2022 11:22:47 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24BB740146E;
        Thu, 31 Mar 2022 11:22:46 +0000 (UTC)
Date:   Thu, 31 Mar 2022 19:22:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Orzel <michalorzel.eng@gmail.com>, akpm@linux-foundation.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kexec: Remove redundant assignments
Message-ID: <YkWPA0XDEMq1NVcr@MiWiFi-R3L-srv>
References: <20220326180948.192154-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326180948.192154-1-michalorzel.eng@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/22 at 07:09pm, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
> 
> Reported by clang-tidy [deadcode.DeadStores]
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> ---
>  kernel/kexec_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..d08904a27362 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -768,7 +768,6 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  				kimage_free_pages(old_page);
>  				continue;
>  			}
> -			addr = old_addr;
>  			page = old_page;
>  			break;
>  		}
> @@ -788,7 +787,6 @@ static int kimage_load_normal_segment(struct kimage *image,
>  	unsigned char __user *buf = NULL;
>  	unsigned char *kbuf = NULL;
>  
> -	result = 0;
>  	if (image->file_mode)
>  		kbuf = segment->kbuf;
>  	else

LGTM, thx

Acked-by: Baoquan He <bhe@redhat.com>

