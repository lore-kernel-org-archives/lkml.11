Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B2C4321E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbiDZJaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbiDZJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:05:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEC6249;
        Tue, 26 Apr 2022 01:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0311BB81C76;
        Tue, 26 Apr 2022 08:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC83C385A4;
        Tue, 26 Apr 2022 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650962703;
        bh=im8fWudeT1VX4m99OVKg5QRNtoJ3f+uKLxsKH0N9C7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTIrFkF+oED7i97icZ3YEBWZi+9l2gpw9vNei5LSrfTJl81IVeb1nflGCgy5aU5k1
         /JEYfqaA8hmiDAvpxPBtsnGh4wIi+TRPvrqmZeBe/y8u3EEmPzeb++78E4c03llHgd
         AmVsFnBulr2v/T4bIZQ1EIfzZvB9JoAvxbdBHf4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 021/146] firmware: cs_dsp: Fix overrun of unterminated control name string
Date:   Tue, 26 Apr 2022 10:20:16 +0200
Message-Id: <20220426081750.660475827@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081750.051179617@linuxfoundation.org>
References: <20220426081750.051179617@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 5b933c7262c5b0ea11ea3c3b3ea81add04895954 ]

For wmfw format v2 and later the coefficient name strings have a length
field and are NOT null-terminated. Use kasprintf() to convert the
unterminated string into a null-terminated string in an allocated buffer.

The previous code handled this duplication incorrectly using kmemdup()
and getting the length from a strlen() of the (unterminated) source string.
This resulted in creating a string that continued up to the next byte in
the firmware file that just happened to be 0x00.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")
Link: https://lore.kernel.org/r/20220412163927.1303470-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/cirrus/cs_dsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index e48108e694f8..7dad6f57d970 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -955,8 +955,7 @@ static int cs_dsp_create_control(struct cs_dsp *dsp,
 	ctl->alg_region = *alg_region;
 	if (subname && dsp->fw_ver >= 2) {
 		ctl->subname_len = subname_len;
-		ctl->subname = kmemdup(subname,
-				       strlen(subname) + 1, GFP_KERNEL);
+		ctl->subname = kasprintf(GFP_KERNEL, "%.*s", subname_len, subname);
 		if (!ctl->subname) {
 			ret = -ENOMEM;
 			goto err_ctl;
-- 
2.35.1



