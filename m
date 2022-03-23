Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D74C43217
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbiCWQKu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiCWQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:10:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110723BBC4;
        Wed, 23 Mar 2022 09:09:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1604210F3;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648051754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WqrWWuXKRrzHJ6UFC9gZ32IPwinpfT6R3F3aGR0VVwY=;
        b=X4JzoMMpDBkSMVC5Mk4l96LINJvAk3IeKVUr+Lohg7oSQr7cwUyecjm9FRbO31k5pWXfiN
        Sh1iMCiy/SU9I8j+oBRZ3GWjCZmTsmxTDgteJLP//dP7shCRn/ky58oi8WgY4f/KlMo5OK
        g0U9tDQ4+SgmWPM/q1vyhl6onQleVpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648051754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WqrWWuXKRrzHJ6UFC9gZ32IPwinpfT6R3F3aGR0VVwY=;
        b=cSjM8+b/zAGCJ/5o85CJCKCXFJ82ce6DmpI+GkIuSv4gIXIZMQ0imc+OgsY4cY6d1xDmqf
        ZZdHhBZgvWBgzVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A654612FC5;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RB4AKCpGO2IgfgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 23 Mar 2022 16:09:14 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH 0/3] clk-raspberrypi: Add support for few more clocks
Date:   Wed, 23 Mar 2022 18:08:56 +0200
Message-Id: <20220323160859.69572-1-iivanov@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches inline functionality between driver available
on RaspberryPi repository and mainline.

Dave Stevenson (1):
  clk: bcm: rpi: Add the BCM283x pixel clock.

Dom Cobley (2):
  clk-raspberrypi: Also support HEVC clock
  clk-raspberrypi: Support VEC clock

 drivers/clk/bcm/clk-raspberrypi.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.26.2

