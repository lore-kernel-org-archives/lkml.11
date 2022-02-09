Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627D7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiBIMR0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiBIMPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:15:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB7C014F3B;
        Wed,  9 Feb 2022 04:01:15 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEDA51EC00F8;
        Wed,  9 Feb 2022 13:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644408069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkJ1KUdpW9iJEEP+6FMRKN1HXiI8x6PSyvRRxME19yw=;
        b=gSTAcCWSnXVzRquK6CCuV354Ta3+IffxeW2vxCLqnyQvVc2lYRGJPB4iiSSMCLcB2msUiJ
        DF2OLP3wuUM1A7oxejUygpwemyqjG9k8E2I0C15DTP1pfNBPXy8X/IEItOMkdFU4h2PUJ/
        peP+4iFqOtaOrfr1kx/4/nyA9w6xXp8=
Date:   Wed, 9 Feb 2022 13:01:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lostway <lostway@zju.edu.cn>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH v2] RAS: Report ARM processor information to userspace
Message-ID: <YgOtBcxNU3Hi4k3O@zn.tnic>
References: <20220126030906.56765-1-lostway@zju.edu.cn>
 <Yfl83r+gPOe9vzed@FVFF77S0Q05N>
 <185FED5B-4C49-4DE1-95D8-594E81B57E31@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <185FED5B-4C49-4DE1-95D8-594E81B57E31@zju.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:41:50AM +0800, lostway wrote:
> <html>
> <head>
>     <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
> </head>
> <body>
> <style>
>     font{
>         line-height: 1.6;
>     }
>     ul,ol{
>         padding-left: 20px;
>         list-style-position: inside;
>     }
> </style>
> <div style = 'font-family:微软雅黑,Verdana,&quot;Microsoft Yahei&quot;,SimSun,sans-serif;font-size:14px; line-height:1.6;'>

...

You need to fix your mail client not to send html crap:

Documentation/process/email-clients.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
