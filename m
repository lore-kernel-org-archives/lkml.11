Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B0AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352463AbiFVIaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351964AbiFVIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:30:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69178D8E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:30:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso15225527pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/QV1xhNLkkz0h8IzzTPXNrpcn+Xxag8bjiRs3XQqgwI=;
        b=LATwNoj2b+xZ/ysjmjybgebbtztcKbrBVf6pDs9mO4SYnm0mM72zHAlgMY8aNuCg2M
         JW7W4tOFgWUElxDKKtswpsV4paSDeKNuARi98OwA44sIydlKhr0f248X6M02bnFzhGMx
         hDKunLaRjfQ06XXPfXhkrzGDUX5koG7H+9uAdb/jF9f7mllS1yPWzgemxzoI6XmpfSkG
         VeBszr33/AZgEK8/Jofo77cIxXuGMV0qB2g9zR/bXpnQKAUI2RUdh8G6QXuBA4w9tuOj
         Pl+AwCXv6ADlJ8vc3CleZ0BhlCMx7H8QiKNJTdrSLKKpUDbcrg5k93ku82KsO6+1+Rp2
         1ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QV1xhNLkkz0h8IzzTPXNrpcn+Xxag8bjiRs3XQqgwI=;
        b=43EqTjEdwQuQFduuLBZQSF4DxmPVpRKK5sGUk1YATv2zK/BfLn5uxYQf7amDKC6xqq
         KH4TC/ZLviFaFup1zVoxvROOygce0UtrV6SYedB5zPiedyrIiqdPjAR1FUnEFeL4RRDf
         vfweQr3mEEpM8GrUM3TQ1B0NkXhGdMQl+xClaegEuwRHtT3s6dQ261kcogJol5dOGT+g
         8nK/lGUBIbFoDwD5Z/j2TyDAIX24u/5A0qCHvEKG84J8J8vEXuU1TJF+JAQp58O9VfCD
         uzyFmhgJOqGuC0dIiX8zlzojaQoDmAPp36llvhJHJJEQpo6Vh3OoWXuolWxv8MoXqFSP
         bxrw==
X-Gm-Message-State: AJIora/ZCVocf0jIz5aGecOM4X92rba2NaWWckbyE0Rb23XVbgnDwQuR
        /Do6Q/EmK+4MzEclELmWsWE=
X-Google-Smtp-Source: AGRyM1ufYrno8gPJAyvKy8yX3pcx3oUU8loKpmmQcjf9tglwtJa+BIqirdHI16g3mh6x/A5HjIPhGw==
X-Received: by 2002:a17:90a:eb0c:b0:1ec:c985:bc06 with SMTP id j12-20020a17090aeb0c00b001ecc985bc06mr8666617pjz.30.1655886605864;
        Wed, 22 Jun 2022 01:30:05 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-12.three.co.id. [180.214.233.12])
        by smtp.gmail.com with ESMTPSA id i185-20020a626dc2000000b0051bf9159d2dsm12841354pfc.208.2022.06.22.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:30:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 60590103801; Wed, 22 Jun 2022 15:30:01 +0700 (WIB)
Date:   Wed, 22 Jun 2022 15:30:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     vgupta@kernel.org, Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Message-ID: <YrLTCXLrr3HB39lv@debian.me>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:04:23PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'to'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  arch/arc/mm/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
> index 5446967ea98d..84fe78c41c37 100644
> --- a/arch/arc/mm/cache.c
> +++ b/arch/arc/mm/cache.c
> @@ -750,7 +750,7 @@ static inline void arc_slc_enable(void)
>   *  -In SMP, if hardware caches are coherent
>   *
>   * There's a corollary case, where kernel READs from a userspace mapped page.
> - * If the U-mapping is not congruent to to K-mapping, former needs flushing.
> + * If the U-mapping is not congruent to K-mapping, former needs flushing.
>   */
>  void flush_dcache_page(struct page *page)
>  {

The patch is OK, but its subject is wrong.

The patch above isn't fixing any syntax errors, but rather minor cleanup.
The subject should have been "Remove duplicate 'to' in the
flush_dcache_page() comment".

I think that this kind of cleanup patches (typofixes) are best done
as part of **actual** work on the code in question (for example
refactoring or fixing build errors).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
