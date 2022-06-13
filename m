Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6CC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245154AbiFMTLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348423AbiFMTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:08:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8D72B26C;
        Mon, 13 Jun 2022 10:04:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A406E1F8F9;
        Mon, 13 Jun 2022 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655139867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XVISaVnB1vPn30pbuFc88gtt4Irs2Teu0f1k4UBxoWY=;
        b=H84jJRWDpspZ5hhfO3QCH29+2YKBuWKyKvZhRnC4RrdCiR+VqYpsUeXJPWCxhNrGc1BChS
        NbBrpJAS7TJincptxOC3konLVuw3DWjmbrfeMlWMCgmRPqnB90sZ9zdnnHneOwvw7f3Mpy
        EoDu2lLuq2XJtZxVI6B59Q4OAese8sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655139867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XVISaVnB1vPn30pbuFc88gtt4Irs2Teu0f1k4UBxoWY=;
        b=VTIx92oKL3yXxSo+VtVyMFW2dAymGe7laH7zbNu5Ho0vSpi9rlexeJIIq2KZ6aZc0au2Zu
        SmrqTuDwxwNVxwDw==
Received: from vasant-suse.fritz.box (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 17B4A2C141;
        Mon, 13 Jun 2022 17:04:27 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     bp@alien8.de, jroedel@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, seanjc@google.com,
        Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v7 0/4] KVM: SEV-ES: Add tests to validate #VC handling
Date:   Mon, 13 Jun 2022 19:04:16 +0200
Message-Id: <20220613170420.18521-1-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

   This is the version 7 of the patch written to add tests for
   AMD SEV-ES #VC handling. This version attempts to
   address review comments to the previous version of the patch.

   Changes v6->v7:
   1. Added information about how to run the tests.
   2. test->priv no longer points to a location on heap.

Thanks,
Vasant

 arch/x86/Kbuild              |   2 +
 arch/x86/Kconfig.debug       |  19 +++++
 arch/x86/kernel/Makefile     |   7 ++
 arch/x86/tests/Makefile      |   3 +
 arch/x86/tests/sev-test-vc.c | 145 +++++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+)
 create mode 100644 arch/x86/tests/Makefile
 create mode 100644 arch/x86/tests/sev-test-vc.c


base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
--
2.32.0

