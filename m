Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0887CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiBKI2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 03:28:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiBKI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:28:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84DCF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:28:46 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89FB11EC0295;
        Fri, 11 Feb 2022 09:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644568120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w70xbuQAa5l/yVbwiEUs1Uc6a87pLNO1YHL0YcV9XJk=;
        b=TdgdaX03efnLMSC6uxeZC0uoWRLpTwwKSLMcuoAprxawPWEt0hJL5iNi0QLkaZmebNw6DM
        u2BEoa27JFjvdGMGVrW0Wae0gB7Ah1EAtRsZe3f0TIy6jm1EuHB+4+S+PclRHwlpJV2Ss8
        hch3m3lDttHG3xAtysAgu+ja5AParE4=
Date:   Fri, 11 Feb 2022 09:28:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Use CPUID 0x8000001f to confirm SME availability
Message-ID: <YgYeOjA1lLEiPEiL@zn.tnic>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211053652.64655-1-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:36:51PM -0600, Mario Limonciello wrote:
> An upcoming change will disable the X86 SME feature flag when the

Which "upcoming change"? When patches are part of the upstream kernel
tree, unclear references to something don't mean a thing - you need to
be more precise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
