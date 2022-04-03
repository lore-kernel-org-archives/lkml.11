Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FBDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 16:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359472AbiDCQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357590AbiDCQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:47:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223E55BC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:45:42 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3MA-00085T-EM; Sun, 03 Apr 2022 18:45:38 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/5] staging: r8188eu: clean up validate_recv_ctrl_frame
Date:   Sun,  3 Apr 2022 18:45:21 +0200
Message-Id: <20220403164526.357371-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the return value, use ieee80211 helpers, simplify the error
handling.

Martin Kaiser (5):
  staging: r8188eu: make validate_recv_ctrl_frame return void
  staging: r8188eu: use ieee80211 helper to check for pspoll
  staging: r8188eu: exit straight away if we have no pspoll frame
  staging: r8188eu: use ieee80211 structs for addresses
  staging: r8188eu: use ieee80211 struct for aid

 drivers/staging/r8188eu/core/rtw_recv.c | 161 +++++++++++-------------
 drivers/staging/r8188eu/include/wifi.h  |   2 -
 2 files changed, 76 insertions(+), 87 deletions(-)

-- 
2.30.2

