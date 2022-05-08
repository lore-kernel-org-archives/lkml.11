Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AECC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 16:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiEHQTA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiEHQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:18:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57C101C0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:15:00 -0700 (PDT)
Received: from dslb-094-219-036-010.094.219.pools.vodafone-ip.de ([94.219.36.10] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nnjYd-00045H-RC; Sun, 08 May 2022 18:14:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: start cleaning up OnAction_back
Date:   Sun,  8 May 2022 18:14:46 +0200
Message-Id: <20220508161451.115847-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a struct ieee80211_mgmt variable to OnAction_back, simplify the
parsing of the received management frame.

Martin Kaiser (5):
  staging: r8188eu: read addr2 from ieee80211_mgmt
  staging: r8188eu: don't check the category in OnAction_back
  staging: r8188eu: read destination address from ieee80211_mgmt
  staging: r8188eu: use back action codes from ieee80211.h
  staging: r8188eu: read back action code from ieee80211_mgmt

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 84 ++++++++++-----------
 1 file changed, 40 insertions(+), 44 deletions(-)

-- 
2.30.2

