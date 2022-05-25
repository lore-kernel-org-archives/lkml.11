Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87163C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 16:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbiEYQMp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiEYQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:12:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A770B41F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:12:42 -0700 (PDT)
Received: from zn.tnic (p200300ea97465795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0CCC1EC0432;
        Wed, 25 May 2022 18:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653495160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=SygsGtRlyyFrMyLCP1TWlnz8KiyWRsZOzOPqgHhLnQI=;
        b=O7nRP3bJOnal0Y0OZ+Bzv48EE3cBwU/BUFSR51yDIgvVOdR6KZwfV+kESjqSdM/JjNVf9J
        p84Js8/dYUCAJxGsqtgDh5h9cokLI0YySW9E86QugQB1e8wO4D11LtQvpFzN6GRcrQ2CWF
        EMDREYcxpBOZVsbYZsCGHrog6mvoRvA=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] x86/microcode: Drop old interface and default-disable late loading
Date:   Wed, 25 May 2022 18:12:28 +0200
Message-Id: <20220525161232.14924-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now tested.

AMD:

[  349.234368] microcode: Attempting late microcode loading - it is dangerous and taints the kernel.
[  349.244128] microcode: You should switch to early loading, if possible.
...
[  349.391934] microcode: Reload completed, microcode revision: 0xa001173

Intel:

[   50.726917] microcode: Attempting late microcode loading - it is dangerous and taints the kernel.
[   50.736139] microcode: You should switch to early loading, if possible.
[   50.745504] microcode: updated to revision 0x718, date = 2019-05-21
[   50.752000] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   50.761158] x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
[   50.771362] microcode: Reload completed, microcode revision: 0x718

Changelog:
----------

v0:

Totally untested, just sending out as a RFC first. This is something
Peter and I talked about recently and think it makes sense.

Borislav Petkov (4):
  x86/microcode: Rip out the OLD_INTERFACE
  x86/microcode: Default-disable late loading
  x86/microcode: Taint and warn on late loading
  x86/microcode: Remove unnecessary perf callback

 arch/x86/Kconfig                     |  15 ++--
 arch/x86/kernel/cpu/common.c         |   2 +
 arch/x86/kernel/cpu/microcode/core.c | 115 +++------------------------
 3 files changed, 20 insertions(+), 112 deletions(-)

-- 
2.35.1
