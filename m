Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15259C28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 12:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiHVMTg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHVMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:19:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D7326F6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:19:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FB7E338EC;
        Mon, 22 Aug 2022 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661170771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Za8B/DV2cpWZrINYeFVAgBaTZ4SxKjc+QduxHPMEnt0=;
        b=oc24QfzkXXKS/JaeMKeGwIIrG9bRsdIjUpQtivXoQQwsjdOcW0GHp1OI3SCc0K5qKkSfPH
        znK84qwGQv/JpvsQwoXtctxcavmNTBmQgos/K2MmPQTtunFSRxnOGGYESB4+aUY/HYnLgF
        eRelq0sTFj+M8D11RoG7xaV/6aJ+D6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661170771;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Za8B/DV2cpWZrINYeFVAgBaTZ4SxKjc+QduxHPMEnt0=;
        b=FHnSdc/UPpA++tzGtkBjkQL3KjO+nZAtwoGb0NXDj/2qMuQEj57yqvS8caKMcxw+18LlM8
        tdMP5e2NQYIG9+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44D4C1332D;
        Mon, 22 Aug 2022 12:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SqwsD1N0A2PuRQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 22 Aug 2022 12:19:31 +0000
Date:   Mon, 22 Aug 2022 14:19:30 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v5.19
Message-ID: <20220822141930.5f43b5e7@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull 1 dmi subsystem update for Linux v5.19 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus


 drivers/firmware/dmi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---------------

Andy Shevchenko (1):
      firmware: dmi: Use the proper accessor for the version field

Sorry for requesting a pull outside of the merge window, but I was on
vacation last 2 weeks.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
