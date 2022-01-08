Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36562C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jan 2022 05:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiAHFMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jan 2022 00:12:03 -0500
Received: from mail-4319.protonmail.ch ([185.70.43.19]:54119 "EHLO
        mail-4319.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiAHFMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:12:02 -0500
Date:   Sat, 08 Jan 2022 05:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641618721;
        bh=/j2Vx1bVQJXPbpvBXRiaCl4gIC+8JojGiGdJO7cqyB0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=QGEtXTxetiOWU/1q7fkqclnSXkd95iuiWFTPSHAVarKQCDtsBuqp2BRAvStu5HQED
         w5nW5A6R5alBGRmzKFBef9WImrZ3eehWK8eVdsqOVsshFTpFHixaewrqf+FWH54+UI
         P1dDg8PZ/NMmfhXfmBTT1O4Z3yvM2HgEkBW+Fo7PmUjW4bkHolRZGTpAToRpwAiaRq
         07E41t4DZV10MBPP4kznsdngux7Hppcvhukg2KmH3k1wNuV/iQWzAq6g+2cA6+b2oI
         p+lJPgd23AUjgnPirTArbYkpiGqMR3nxpt3ldwYYO4ZBAaSOUZJXnajhsqFNz9ZWvW
         U9VJJpW9HwoQw==
To:     jani.nikula@linux.intel.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     ashisharora.linux@outlook.com, intel-gfx@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com, Aun-Ali Zaidi <admin@kodeit.net>
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCH] drm/i915: Discard large BIOS framebuffers causing display corruption.
Message-ID: <20220108050812.6303-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't observed "display corruption", but on my MacBookPro16,1 the botto=
m
and right edges of the TTY are not on the screen, so a few lines of text
cannot be seen.

This also occurs on the internal displays of all (as far as I know) other
2018-2020 Intel Macbooks when using the Intel GPU (The 15" and 16" ones
also have an AMDGPU, but this issue occurs when they have the Intel GPU
set as the boot gpu).

There's a similar patch that hasn't been sent upstream that people with the=
se
Macbooks have been using:
https://github.com/aunali1/linux-mbp-arch/blob/master/7001-drm-i915-fbdev-D=
iscard-BIOS-framebuffers-exceeding-h.patch

Cc: Aun-Ali Zaidi <admin@kodeit.net>

--
Thanks,
Orlando

