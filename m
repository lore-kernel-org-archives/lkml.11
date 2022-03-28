Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F83FC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 07:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiC1H6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 03:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiC1H6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:58:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333E0E0B1;
        Mon, 28 Mar 2022 00:57:07 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B8FB1EC03AD;
        Mon, 28 Mar 2022 09:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648454221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1SO2tTLkDgNIJB8WVLVL5gv7dKbkgH3H7QX1GII/UIg=;
        b=geNHG+uC+BsHhRbcfEwekt/WScmoIXcO2OZGHyHPPoydbiaKPE45tjcJU8DmmK9M7jVewQ
        eoLFH6K0JHXCpqjQpMwT8O4nczDfjXcVxVf0+SRGuLpOsmOD/vp6Pmv88L6A/h/wy/+Khc
        yT6jeemg/vmJjDvhHZNtsSql8skjrpA=
Date:   Mon, 28 Mar 2022 09:56:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gwml@vger.gnuweeb.org, x86@kernel.org,
        David Laight <David.Laight@aculab.com>,
        Jiri Hladky <hladky.jiri@googlemail.com>
Subject: Re: [PATCH v5 1/2] x86/delay: Fix the wrong asm constraint in
 `delay_loop()`
Message-ID: <YkFqSr7dMSXPbmyo@zn.tnic>
References: <20220310015306.445359-1-ammarfaizi2@gnuweeb.org>
 <20220310015306.445359-2-ammarfaizi2@gnuweeb.org>
 <YkDZY8n1k5SJw9st@zn.tnic>
 <6f020f3a-da63-09a5-95f4-167429ff3727@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f020f3a-da63-09a5-95f4-167429ff3727@gnuweeb.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:29:26AM +0700, Ammar Faizi wrote:
> See the example from Alviro here:
> 
>   https://lore.kernel.org/lkml/CAOG64qPgTv5tQNknuG9d-=oL2EPQQ1ys7xu2FoBpNLyzv1qYzA@mail.gmail.com/

Not the same thing - see David's reply there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
