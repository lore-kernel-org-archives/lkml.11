Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB1C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbiCHIDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbiCHIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:03:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5B3E5EF;
        Tue,  8 Mar 2022 00:02:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EAF69210EF;
        Tue,  8 Mar 2022 08:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646726526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUnK/Mtz62xa6TVkJ64+VKjEHBAlCRROy3iWEztQcOQ=;
        b=svAFWFtd7OsypoKWPEGMy7ZXq/a5EfYbCSFHsCxmCc48ybhPMOh4Wt1YKCNvERWR2dEo5J
        HG1ZAG/mE3Tm8ijJhhu4hgxxBQwYDNY+7X1/bISr4HTSgls1UuNbS5OyAzzgUix+ILkEWV
        5EI9EofKrpe8ihNbyIiCzVApiT/Czzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646726526;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUnK/Mtz62xa6TVkJ64+VKjEHBAlCRROy3iWEztQcOQ=;
        b=OtP8IJNPwHI6dsdwQl1Gta9gjdtrBu1CPTno/8PdfdvCIDYfqDJo8tfRssnNG/TywXGvRy
        TEwgYT9cvswZN2Dw==
Received: from quack3.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD739A3B95;
        Tue,  8 Mar 2022 08:02:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9EF6EA0609; Tue,  8 Mar 2022 09:02:06 +0100 (CET)
Date:   Tue, 8 Mar 2022 09:02:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] udf: remove redundant assignment of variable etype
Message-ID: <20220308080206.bumkpk2orl7m3cpt@quack3.lan>
References: <20220307152149.139045-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307152149.139045-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-03-22 15:21:49, Colin Ian King wrote:
> Variable etype is being assigned a value that is never read. The
> variable and assignment are redundant and can be removed.
> 
> Cleans up clang scan build warning:
> fs/udf/super.c:2485:10: warning: Although the value stored to 'etype'
> is used in the enclosing expression, the value is never actually read
> from 'etype' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/udf/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 48871615e489..4042d9739fb7 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2474,7 +2474,6 @@ static unsigned int udf_count_free_table(struct super_block *sb,
>  	unsigned int accum = 0;
>  	uint32_t elen;
>  	struct kernel_lb_addr eloc;
> -	int8_t etype;
>  	struct extent_position epos;
>  
>  	mutex_lock(&UDF_SB(sb)->s_alloc_mutex);
> @@ -2482,7 +2481,7 @@ static unsigned int udf_count_free_table(struct super_block *sb,
>  	epos.offset = sizeof(struct unallocSpaceEntry);
>  	epos.bh = NULL;
>  
> -	while ((etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1)
> +	while (udf_next_aext(table, &epos, &eloc, &elen, 1) != -1)
>  		accum += (elen >> table->i_sb->s_blocksize_bits);
>  
>  	brelse(epos.bh);
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
