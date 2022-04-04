Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517F6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 22:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiDDWr6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344674AbiDDWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:46:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9710937BD7;
        Mon,  4 Apr 2022 14:57:04 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2554E1EC04AD;
        Mon,  4 Apr 2022 23:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649109419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1v8Nh6GMcNHzf1PKyvbirBT1D8L1EYpKSAB3t1pC2ok=;
        b=hRsUotSJcUNsyuGu0M85tQbulpFIJ6YBu/iJsodQyWyxCLmysp5No/OERS6Tqs0H3vbW3k
        HvAyG/nRv+rLVoHEYJjw23HxSrGIkv4Z0/kKAdf62dRpqZTkPlW/vfFmQqo5BC1/UkhXjv
        LfM6EmuqVpbYvbNtAi7w6W8GaJfhJFI=
Date:   Mon, 4 Apr 2022 23:56:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 2/3] x86/mce: Define function to extract ErrorAddr
 from MCA_ADDR
Message-ID: <YktpqKye+t462Y1p@zn.tnic>
References: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220225193342.215780-3-Smita.KoralahalliChannabasappa@amd.com>
 <YkWrlTIK/ZxsQekX@zn.tnic>
 <YkmeJFXXbu3aLzzw@zn.tnic>
 <Yknsbp+zMh8Uev8+@zn.tnic>
 <87mth2kkhc.ffs@tglx>
 <YkoHKTuGaFfsF6qb@zn.tnic>
 <54599d6c-204e-d7f6-21b6-15df7acad53d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54599d6c-204e-d7f6-21b6-15df7acad53d@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:55:21PM -0700, Smita Koralahalli wrote:
> I didn't quite understand what needs to be moved to mce/internal.h. Was that
> addressed to me?  The function call smca_extract_err_addr() is in mce/core.c
> and the definition in mce.h

In your current v4, the function definition is in
arch/x86/kernel/cpu/mce/amd.c

However, since it needs to be inlined into both callsites because
mce_read_aux() is marked noinstr, the definition should be

static __always_inline void smca_extract_err_addr(struct mce *m)

and that definition should be in the header mce/internal.h

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
