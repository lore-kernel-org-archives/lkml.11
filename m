Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05157C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiBKBBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 20:01:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiBKBBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:01:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C275F68
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:01:09 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l9so1753570plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdgcHpK2QxPcOYOUkcGQd2wPLDeTg88ycTZ52tqwOpM=;
        b=ayaQeq+iHp1StJk08sGOB8wL9hF2ax+YroHj/Q2xe57EsF2tmwRM+bRcoP5B6RJSao
         zVRGQxURnYafJmjj2pjUpW4Gbc4ywJAnHBFGFsrK1qUnpQSCr8sghtVn51G6hSguVMPD
         lHPaakslQ0USKodMgm+Qx4Kb22euGUvZ0qMSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdgcHpK2QxPcOYOUkcGQd2wPLDeTg88ycTZ52tqwOpM=;
        b=05kweHjp5lxqtMlF2OIljK4ajI1L37AWug5Iyeh9gwALk4/CO8spys8WI6aXfcMcxQ
         6VhldteIEjCqK0UtmWCEFzdJJX2e//tzFYhkONh6p3B8RRITRwH9WgCX0L6bTk1zCVwc
         PC5Trgkb9VqIohG0CD2n5qaH2rV06IapYx4YE+bxgDwcdV8BcBBmlf/PpdpbTe8LWuzn
         p0U6P5+4x6tetw1+L0BDHw0shbOItEJ7vQytxjRiKiXQOeYpKN868zoUdWhocDgXTwjc
         jH6qqLtM51w+JkehPJAdjV+Og8P0l1YFhvulZhIWrXPd8QGr4Rc7POXBZmeo6FsUcnon
         fHYg==
X-Gm-Message-State: AOAM530YjKIcNHXOCOfvqLfhyAg03lQVt9fFt/ZH/c0xSq38sjkRvRdR
        ELDrTft1YF/Spw6VdV0pLhjeVw==
X-Google-Smtp-Source: ABdhPJy2kB/YH9xMcBfAS96T6mrN64LEHeytd1RwomHu8ZQbb2OHvCkkk5zZkV2I8D5+PzLBVw0c7Q==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr10224104plq.35.1644541268697;
        Thu, 10 Feb 2022 17:01:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c20sm13253330pfl.46.2022.02.10.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:01:08 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:01:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 11/12] lkdtm: Fix execute_[user]_location()
Message-ID: <202202101700.985C29A@keescook>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:38:24PM +0200, Christophe Leroy wrote:
> execute_location() and execute_user_location() intent
> to copy do_nothing() text and execute it at a new location.
> However, at the time being it doesn't copy do_nothing() function
> but do_nothing() function descriptor which still points to the
> original text. So at the end it still executes do_nothing() at
> its original location allthough using a copied function descriptor.
> 
> So, fix that by really copying do_nothing() text and build a new
> function descriptor by copying do_nothing() function descriptor and
> updating the target address with the new location.
> 
> Also fix the displayed addresses by dereferencing do_nothing()
> function descriptor.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

This looks good. I might rename variables in the future (e.g. to avoid
the churn from adding _text) but also, that does help keep it clear. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/perms.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 035fcca441f0..1cf24c4a79e9 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -44,19 +44,34 @@ static noinline void do_overwritten(void)
>  	return;
>  }
>  
> +static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
> +{
> +	if (!have_function_descriptors())
> +		return dst;
> +
> +	memcpy(fdesc, do_nothing, sizeof(*fdesc));
> +	fdesc->addr = (unsigned long)dst;
> +	barrier();
> +
> +	return fdesc;
> +}
> +
>  static noinline void execute_location(void *dst, bool write)
>  {
> -	void (*func)(void) = dst;
> +	void (*func)(void);
> +	func_desc_t fdesc;
> +	void *do_nothing_text = dereference_function_descriptor(do_nothing);
>  
> -	pr_info("attempting ok execution at %px\n", do_nothing);
> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>  	do_nothing();
>  
>  	if (write == CODE_WRITE) {
> -		memcpy(dst, do_nothing, EXEC_SIZE);
> +		memcpy(dst, do_nothing_text, EXEC_SIZE);
>  		flush_icache_range((unsigned long)dst,
>  				   (unsigned long)dst + EXEC_SIZE);
>  	}
> -	pr_info("attempting bad execution at %px\n", func);
> +	pr_info("attempting bad execution at %px\n", dst);
> +	func = setup_function_descriptor(&fdesc, dst);
>  	func();
>  	pr_err("FAIL: func returned\n");
>  }
> @@ -66,16 +81,19 @@ static void execute_user_location(void *dst)
>  	int copied;
>  
>  	/* Intentionally crossing kernel/user memory boundary. */
> -	void (*func)(void) = dst;
> +	void (*func)(void);
> +	func_desc_t fdesc;
> +	void *do_nothing_text = dereference_function_descriptor(do_nothing);
>  
> -	pr_info("attempting ok execution at %px\n", do_nothing);
> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>  	do_nothing();
>  
> -	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
> +	copied = access_process_vm(current, (unsigned long)dst, do_nothing_text,
>  				   EXEC_SIZE, FOLL_WRITE);
>  	if (copied < EXEC_SIZE)
>  		return;
> -	pr_info("attempting bad execution at %px\n", func);
> +	pr_info("attempting bad execution at %px\n", dst);
> +	func = setup_function_descriptor(&fdesc, dst);
>  	func();
>  	pr_err("FAIL: func returned\n");
>  }
> @@ -153,7 +171,8 @@ void lkdtm_EXEC_VMALLOC(void)
>  
>  void lkdtm_EXEC_RODATA(void)
>  {
> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
> +	execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing),
> +			 CODE_AS_IS);
>  }
>  
>  void lkdtm_EXEC_USERSPACE(void)
> -- 
> 2.31.1
> 

-- 
Kees Cook
