Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02092C43219
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574679AbiDEXAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384641AbiDEOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:18:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1E5F8FC;
        Tue,  5 Apr 2022 06:04:31 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB73E1EC01D4;
        Tue,  5 Apr 2022 15:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649163866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YwtUPcvJGfTPFgg2iCmuMJC0p4mv70/YI6fdCVV5sVs=;
        b=egA9gG8KXTlrF1PZHdT9hruffdqmp0d+l2Hd0Y3qQCyXegdk8RHmatVIqDTfEnESyqQ+6k
        40I5FZrZenC59Eq3XE/5fRHBeSK0v/2TsQuG5b2kLbSj5fGdvJpHvAqCPDGoqvYiDw02CQ
        Mc5T6qpldWJjp5PKoXYf17UeQJ9mjMg=
Date:   Tue, 5 Apr 2022 15:04:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Biener <rguenther@suse.de>
Cc:     Michael Matz <matz@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Ykw+W7IoWmPFEaf5@zn.tnic>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.20.2204051232101.963@wotan.suse.de>
 <79p0n5po-1377-4q33-3599-6129o38p96p@fhfr.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79p0n5po-1377-4q33-3599-6129o38p96p@fhfr.qr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:53:18PM +0200, Richard Biener wrote:
> Indeed.  Simply cast vendor/product to (unsigned) in the USB_ID
> macro to avoid arithmetic shifts.

Yeah, Boris is going to turn on his editor and do patches... :-)

Thx guys!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
