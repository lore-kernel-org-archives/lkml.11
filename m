Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD182C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiBMMhS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 07:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBMMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:37:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9935AEFD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:37:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54320210EE;
        Sun, 13 Feb 2022 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644755831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9czmSGPY3nPWptFPCkPuWs1wn6iugfKjUHNktEIIfn0=;
        b=0vH+7crR/bFQJyUOfn4hDkvNJUhLKPHKaMlk++G0Kli1kd81vhiWpoOGC4S5kTk7tkpk/G
        VaLNbYaq5NIxEjl8Nw1ybtLeXdKK2urLZ+vrn9WtNYKj+je0ayn3g25dSOC92E3LhgpGwU
        FJylmxUn6g0DEKT6UMTjoAW/wuegWIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644755831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9czmSGPY3nPWptFPCkPuWs1wn6iugfKjUHNktEIIfn0=;
        b=S3pF3WGyvxakE339AYTm9bnkabWgmisRwBgfoG11qf95d4zmSC20qPJEXwfLP9d1mypGev
        Y2KWe9nKfo4aUHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3347B1331A;
        Sun, 13 Feb 2022 12:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tNEmC3f7CGLdQAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Feb 2022 12:37:11 +0000
Date:   Sun, 13 Feb 2022 13:37:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <Ygj7feK+vdtPw6zj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent scheduling fix for 5.17.

Thx.

---

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc4

for you to fetch changes up to 13765de8148f71fa795e0a6607de37c49ea5915a:

  sched/fair: Fix fault in reweight_entity (2022-02-06 22:37:26 +0100)

----------------------------------------------------------------
- Fix a NULL-ptr dereference when recalculating a sched entity's weight

----------------------------------------------------------------
Tadeusz Struk (1):
      sched/fair: Fix fault in reweight_entity

 kernel/sched/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
