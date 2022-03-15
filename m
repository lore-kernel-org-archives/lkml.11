Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 18:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351041AbiCOSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351097AbiCOSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:38:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D791483BB;
        Tue, 15 Mar 2022 11:36:50 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A46BC1EC04C1;
        Tue, 15 Mar 2022 19:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647369404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JjvDDVjCifPJvTUzn+nwAnDCaFN2QldIAfWhx2SS42I=;
        b=j3WZ6Nab/2RxzMCSJtXS4vd4YVwY4+8yI0z6+rHAlbXVUUp5XeyK54YcZ81dvK83Fhajg3
        3GTXhSLXc5wzMWixD4g2CRi1VOgGTRfP5exOnqsJkWKAp/R78Ze0vkArDOqZWnboIdZD18
        Q+fYJxc0XOHIhy0GeFTwYEegeYL/fEA=
Date:   Tue, 15 Mar 2022 19:34:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 0/2] New CMCI storm mitigation for Intel CPUs
Message-ID: <YjDcN9XRa0teenD2@zn.tnic>
References: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <20220315181509.351704-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315181509.351704-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:15:07AM -0700, Tony Luck wrote:
> Smita: Unless Boris finds a some more stuff for me to fix, this
> version will be a better starting point to merge with your changes.

Right, I'm wondering if AMD can use the same scheme so that abstracting
out the hw-specific accesses (MSR writes, etc) would be enough...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
