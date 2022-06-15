Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7858C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 17:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbiFORRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiFORRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:17:08 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC358381A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mxlPCZ+TCo9rjngJAxk2JBd7q9Ja8RZEj1mwABWaau0=; b=rcsIHRUNLuWqvanX6FalgUohyZ
        I51RGwV6xcCwHJkLPSn+YqGFaGFBnbYtG8nbncwbho+pp8vPPYjOwgr20MZzTdzEboQjaOMWD1jUi
        6DvLzYloMF2wBWa6GB6NmENcsoDx5HmQ1EfftQ8bZzsnSnA5zgIea4NkVKnk4rxD/wJ0=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1Wdd-0005iN-Jd; Wed, 15 Jun 2022 10:17:05 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Daniel Watson <ozzloy@challenge-bot.com>
Subject: [PATCH v3 0/4] call rtw_IOL_append_*_cmd directly
Date:   Wed, 15 Jun 2022 10:16:59 -0700
Message-Id: <cover.1655312169.git.ozzloy@challenge-bot.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Watson <ozzloy@challenge-bot.com>

This patchset calls the rtw_IOL_append_*_cmd group of functions
directly and removes the #define wrappers.

Daniel Watson (4):
  staging: r8188eu: call rtw_IOL_append_WB_cmd directly
  staging: r8188eu: call rtw_IOL_append_WW_cmd directly
  staging: r8188eu: call rtw_IOL_append_WD_cmd directly
  staging: r8188eu: call rtw_IOL_append_WRF_cmd directly

 drivers/staging/r8188eu/core/rtw_iol.c    |  8 ++++----
 drivers/staging/r8188eu/include/rtw_iol.h | 24 ++++++++---------------
 2 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.34.1

