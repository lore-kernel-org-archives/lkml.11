Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9FC25B0F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 22:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiHLWZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiHLWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225AAE61;
        Fri, 12 Aug 2022 15:25:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BE965C0093;
        Fri, 12 Aug 2022 18:25:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 18:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660343122; x=1660429522; bh=MihXDT4RnPEouVvFPrPaSH/gv
        3/IeZRAiImwW7f+1Rw=; b=WXrliUJRNbOCEcWHfRIMexq2AMZpMeFFbY5Uh1CcX
        wvC0y6tOLwHVQTD9VSOG6NKYP4f1ypbMiy8K24A4zO1PqSmPe+r4JsQFlURQfnVG
        lVYkVNrhRH6aGQBNBkF1E/9zmC9vdZMiPLJSDJnY7J/D99qlSuFMZP5V4ZA35zU0
        +tytHoYpU4bjsndJQVFX5b7y9pXYe0hJT4ix0Eb7eS8u9CbtCex/nIWA0S4sWiyq
        mTeyUCVVl3N45qAt9yFmRpiIc6+RxGwjRpSwdkhlHmeO0eE6BPVokAndCzVY1zcK
        QToJAcprOY0IYMa734i2HSW1PSvpdbSRDf5fatgl+P8bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660343122; x=1660429522; bh=MihXDT4RnPEouVvFPrPaSH/gv3/IeZRAiIm
        wW7f+1Rw=; b=Bl8yqRsUGbWjUK0QIclLBOdIoKE3KDeSRDMLfSNH1fJz10EUk23
        3zO1OQTxaDHZGG/wkNwdaZGB7AFp34sRP16AGtUr0vPuxpu/NWYiXMhrtdCAafJn
        irwSMoWWog6pqF4Tgfcxvx7naR7bPqRTiKa+meZlSjJz5LsagM0mGTG2N258Tkz9
        BTq3xITb80Se3MiDv8a+JdBEvgyZT70oSpL3LNCegrluxiSAIYBKnvVlbZZgvMW9
        ZZrGPKanstgxRNTFnd44iISm9MTIgStHOZ9ijVVrEWzO4bn/6s9iDPHObIVhiGaP
        w8YN69dIshFFqRGlTPC2hK74AJST6bcMarQ==
X-ME-Sender: <xms:UtP2Yswx3lOIQna1ySl-WFsUwocjVLm1sLZLBia1veCPqEiQ08-rUg>
    <xme:UtP2YgSYXm5HNZP_Lfu5q4UDi3WjNpmDQTL1PTX9HVKTQrV9zuR9XokInqaIJGpr3
    S5EOR6Z88EbRlVJaXw>
X-ME-Received: <xmr:UtP2YuWp6o0bENcerEVk-A11IuC3Tvx0XbrTY1QitwitLjNElrNZcAU_wS69>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:UtP2YqiAjbv-w7bMs32L99DQxWe-oVRVLWgeC8soFOaZfDkZs-1-ng>
    <xmx:UtP2YuB7-oM-NsHok035sUlXJzwlKCiY0kD4hDf7RD0PseDs2xHBtA>
    <xmx:UtP2YrKaWDBbvJiTu6LHB2LEoBytqElU4wh8rVlPvhXkyXjSSGLgQA>
    <xmx:UtP2YhMlZVr8jpts8E5DLtKEWikIdkEeQcrjas9jgAl2w_Nx3GjfUg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:18 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 0/6] asus-wmi: cleanup dgpu_disable, egpu_enable, panel_od
Date:   Sat, 13 Aug 2022 10:25:03 +1200
Message-Id: <20220812222509.292692-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does two things for previously added features:
- dgpu_disable
- egpu_enable
- panel_od

The fixes add missing documentation, and the refactors vastly clean up how
the features work, including reading the values from WMI methods on *_show()
and checking the result correctly (these methods return 1 on success).

Luke D. Jones (6):
  Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
  Fixes: 382b91db8044 ("asus-wmi: Add egpu enable method")
  Fixes: ca91ea34778f ("asus-wmi: Add panel overdrive functionality")
  asus-wmi: Refactor disable_gpu attribute
  asus-wmi: Refactor egpu_enable attribute
  asus-wmi: Refactor panel_od attribute

 .../ABI/testing/sysfs-platform-asus-wmi       |  28 +++
 drivers/platform/x86/asus-wmi.c               | 231 ++++++------------
 2 files changed, 103 insertions(+), 156 deletions(-)

-- 
2.37.1

