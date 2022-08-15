Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE24C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiHOR00 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiHOR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:24 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10ADE0C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q+YBa7Xn+23B6E1eKZkzm4MvjKZcpyjVDESmGwFP2nk=;
        b=aTlYGIPL8+kTbl7x4mQXR5eTHrXP54Gk4sByKjaeRKo1X5XV3Iz3hzF+Gv+kvnUlYBPgzA
        N97Im3zwv22jpND2RIH+gMZmRrpBgae17NS+JKYxE2VgpQyeZGpfOuLR9CL3XO7rpNCpGT
        QYoUPN+5uRAN2L3Cw8Mvm9+LANTufVQ=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Printbufs v6
Date:   Mon, 15 Aug 2022 13:26:02 -0400
Message-Id: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew - here's the rest of the patch series. My brand new email account was
suspended halfway through because it thought I was sending spam... subtle
commentary on the contents, perhaps?

Cheers


