Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 10:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiEKK1y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiEKK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:26:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060AC289B0;
        Wed, 11 May 2022 03:26:29 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CDDB1EC0531;
        Wed, 11 May 2022 12:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652264784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VEp2t13QqBjlm/ZQxi+DnPO1+jQii+Zbpf8zWxlnnl0=;
        b=GIcHGpSHKshTcEogyx9MHmP5tZbnef7UvraEy3lU7NVYz/p/8IkqapaeuIAFISMxxKc/RW
        ioVLi+L4F6qnd0IJkflmfDtGERwaqh1iJOUMpBZIT++sUTSj5ZmCioV6XtaufMOQKo6N/T
        OBZOj4BZd6ZMfXSqugsKoWBpeYvzcsE=
Date:   Wed, 11 May 2022 12:26:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 02/18] EDAC/amd64: Remove scrub rate control for Family
 17h and later
Message-ID: <YnuPU41KWLer9d5T@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509145534.44912-3-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:55:18PM +0000, Yazen Ghannam wrote:
> @@ -251,6 +234,9 @@ static int set_scrub_rate(struct mem_ctl_info *mci, u32 bw)
>  	struct amd64_pvt *pvt = mci->pvt_info;
>  	u32 min_scrubrate = 0x5;
>  
> +	if (pvt->umc)
> +		return -EPERM;

Since this function is testing families, it might be more
straightforward for the check to be:

	if (pvt->fam >= 0x17)

> +
>  	if (pvt->fam == 0xf)
>  		min_scrubrate = 0x0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
