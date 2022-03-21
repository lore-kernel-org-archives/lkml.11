Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 10:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbiCUKjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbiCUKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:39:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06C15A00
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:38:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2603210DE;
        Mon, 21 Mar 2022 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647859089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKIP6/EfRPs7jZ16q4Ywuc1WERiFn2vc4PjxoCCm6QM=;
        b=x8pRmMyTdPYD6MaWkUnJhp59ewp+14ZmAG+BzJdhtUSycD37BCaq6LqX0r7Un+rFj+kRlW
        UtjGLIo+P3uHJK3u6JO1STOm5+ndm3SyGgpmplBpWcTu+ccRzn8wQGXs1fPLjPpduMgNca
        DB7uJG9psxvRwOuKIEN9Y2TDy2pHWLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647859089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKIP6/EfRPs7jZ16q4Ywuc1WERiFn2vc4PjxoCCm6QM=;
        b=R1x6xY+2o4KrXKL4E/NrCjlAd3afIGAiwQghLldneroIFeyrnD6raiJ7GJMgZLdjend5FA
        X10gzW12pGWiLtAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5EC313AD5;
        Mon, 21 Mar 2022 10:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OOJiLJFVOGIyAQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:38:09 +0000
Date:   Mon, 21 Mar 2022 11:38:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for 5.18
Message-ID: <YjhVkhyJPuz66ZTA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86 SEV fix for 5.18.

Thx.

---

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.18_rc1

for you to fetch changes up to 5f117033243488a0080f837540c27999aa31870e:

  x86/head64: Add missing __head annotation to sme_postprocess_startup() (2022-02-12 11:37:09 +0100)

----------------------------------------------------------------
- Add a missing function section annotation

----------------------------------------------------------------
Marco Bonelli (1):
      x86/head64: Add missing __head annotation to sme_postprocess_startup()

 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
