Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77557C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 20:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiDMUKZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiDMUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:10:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE937B545
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:07:52 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nejHI-0005wN-LP; Wed, 13 Apr 2022 22:07:48 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: some more cleanups
Date:   Wed, 13 Apr 2022 22:07:38 +0200
Message-Id: <20220413200742.276806-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of simple cleanups in the code that handles incoming
frames.

Martin Kaiser (4):
  staging: r8188eu: use ieee80211 helper to read the qos tid
  staging: r8188eu: merge _mgt_dispatcher into mgt_dispatcher
  staging: r8188eu: use ieee80211 helpers in mgt_dispatcher
  staging: r8188eu: pkt_newalloc is not used

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 35 +++++++++------------
 drivers/staging/r8188eu/core/rtw_recv.c     |  3 +-
 drivers/staging/r8188eu/include/rtw_recv.h  |  1 -
 drivers/staging/r8188eu/include/wifi.h      |  2 --
 4 files changed, 16 insertions(+), 25 deletions(-)

-- 
2.30.2

