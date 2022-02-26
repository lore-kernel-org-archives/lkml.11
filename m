Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 14:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiBZOth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 09:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiBZOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 09:49:34 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45052186220
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 06:49:00 -0800 (PST)
Received: from ipservice-092-217-092-093.092.217.pools.vodafone-ip.de ([92.217.92.93] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nNyNS-0007Wh-3Z; Sat, 26 Feb 2022 15:48:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/6] staging: r8188eu: another round of removals
Date:   Sat, 26 Feb 2022 15:48:37 +0100
Message-Id: <20220226144843.1118951-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes some unused variables, functions and defines in
rtw_recv.[ch]

Martin Kaiser (6):
  staging: r8188eu: smooth_rssi_data is not used
  staging: r8188eu: irq_prepare_beacon_tasklet is unused
  staging: r8188eu: cnt is set but not used
  staging: r8188eu: recvframe_push is not used
  staging: r8188eu: get_rx_status is not used
  staging: r8188eu: remove unused define

 drivers/staging/r8188eu/core/rtw_recv.c    |  2 --
 drivers/staging/r8188eu/include/rtw_recv.h | 34 ----------------------
 2 files changed, 36 deletions(-)

-- 
2.30.2

