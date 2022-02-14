Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4803BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 12:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353067AbiBNMU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:20:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352993AbiBNMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:20:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CE49274;
        Mon, 14 Feb 2022 04:20:44 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BFDF1EC04AD;
        Mon, 14 Feb 2022 13:20:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644841238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=awmOYe0q2eigKq4ItO9KPxIRltMibHr3LJFHTIRlYXU=;
        b=gZLjxhvBJTVORBJtqIUTiIK4na7LGN3pMvm2SlZSnisTU43XeCmXW7yJq2Vl0+2CYlEeaq
        wdNAEfJZWzxiGMzG4IQYdaQlKJV4HnGKEqyIRhsHbQDuRpPqtGFDS+hWG8kSz/YKB5UmTV
        ABGVWy7ScWOhtYNEX7DSJLpbXorgR7A=
Date:   Mon, 14 Feb 2022 13:20:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 12/24] EDAC/amd64: Define function to get number of
 interleaved channels
Message-ID: <YgpJHNfS6cs1aEjE@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-13-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-13-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 08:41:03PM +0000, Yazen Ghannam wrote:
> Move number of interleaved channel calculation to a separate helper
> function. Drop unused cases.

... or by looking at that change, I think you want to have each separate
step in the address massaging be a separate function. Which, if so,
makes sense but you have to say it...

...

> +static void get_intlv_num_chan(struct addr_ctx *ctx)
> +{
> +	/* Save the log2(# of channels). */
> +	switch (ctx->intlv_mode) {
> +	case NONE:
> +		ctx->intlv_num_chan = 0;
> +		break;
> +	case NOHASH_2CH:
> +	case DF2_HASH_2CH:
> +		ctx->intlv_num_chan = 1;
> +		break;
> +	default:
> +		/* Valid interleaving modes where checked earlier. */

"were"

> +		break;
> +	}
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
