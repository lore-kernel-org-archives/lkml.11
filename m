Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF79CCA486
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380196AbiFGVPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359766AbiFGUQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:16:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DA1CAC13;
        Tue,  7 Jun 2022 11:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15BFEB8237C;
        Tue,  7 Jun 2022 18:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B8DC385A2;
        Tue,  7 Jun 2022 18:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626517;
        bh=j4qLntO3VaOtB7btRAveV4YpRZHf6JXJpBSgnbjuGuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejCAntd5wtPSfZkx21hWrH0aNbim7m1tVVTfHRhFeAR+fAevxukdKidGjNG7oeh9T
         5zoIYCMhDPeaTEVsCU2skSE/vmV1vaH2hxIGAjVHvFasq8JTavHJEDH4O9/p89y3NW
         15jeUFs3Vq/08htaHVhWHUxAvmTTylgdRfmnS1bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 407/772] regulator: scmi: Fix refcount leak in scmi_regulator_probe
Date:   Tue,  7 Jun 2022 18:59:59 +0200
Message-Id: <20220607165001.001897532@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 68d6c8476fd4f448e70e0ab31ff972838ac41dae ]

of_find_node_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20220516074433.32433-1-linmq006@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 1f02f60ad136..41ae7ac27ff6 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -352,7 +352,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 			return ret;
 		}
 	}
-
+	of_node_put(np);
 	/*
 	 * Register a regulator for each valid regulator-DT-entry that we
 	 * can successfully reach via SCMI and has a valid associated voltage
-- 
2.35.1



