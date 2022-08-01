Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7250FC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiHALf7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 07:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHALfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:35:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8631DCF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:35:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9CBE4DBCD;
        Mon,  1 Aug 2022 11:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659353745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u312vnP4fcLCjD3jzYn5nuqGU84caAu/TIHOD8MpWW0=;
        b=tS5rVfI1lCsI8DNUbAdWPexg68SZhFr2v4e2KMqHpHzprqFeXgKv96Q3/HUjco4tU4k1Ts
        ENhwdvYvFfFC7DYwRdHzQq2/xbS8WFEBLy3xb0WIOc0/vhma+3WnY1+pLMnh2J9QP4GhFQ
        hyYPgmQBCchOFPFyEUsiSUdisj1g7Do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659353745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u312vnP4fcLCjD3jzYn5nuqGU84caAu/TIHOD8MpWW0=;
        b=zB3Ehmkf0kQGTr8WyQs6Q/LUrCvEvXFchfr+aKDLUxP/HYL/4inc1CNXZvID7kGeexfAdR
        Mc3hWIWmtWlrTSCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE1CC13A72;
        Mon,  1 Aug 2022 11:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id irYtNpG652KeBQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 11:35:45 +0000
Date:   Mon, 1 Aug 2022 13:35:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.0
Message-ID: <Yue6jQd37wpssGeZ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull a couple of x86/misc fixes for 6.0.

Thx.

---

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.0_rc1

for you to fetch changes up to d906fa730827456711ce29c1f2994a0ccaff49dc:

  hwmon: (k10temp): Add support for new family 17h and 19h models (2022-07-20 17:39:11 +0200)

----------------------------------------------------------------
- Add a bunch of PCI IDs for new AMD CPUs and use them in k10temp

- Free the pmem platform device on the registration error path

----------------------------------------------------------------
Johan Hovold (1):
      x86/pmem: Fix platform-device leak in error path

Mario Limonciello (2):
      x86/amd_nb: Add AMD PCI IDs for SMN communication
      hwmon: (k10temp): Add support for new family 17h and 19h models

 arch/x86/kernel/amd_nb.c | 13 +++++++++++++
 arch/x86/kernel/pmem.c   |  7 ++++++-
 drivers/hwmon/k10temp.c  | 12 ++++++++++++
 include/linux/pci_ids.h  |  3 +++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
