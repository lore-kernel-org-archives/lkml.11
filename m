Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1640C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiCULFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiCULFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:05:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D4CFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 961F2B81233
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36ECC340F2;
        Mon, 21 Mar 2022 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647860649;
        bh=zv668qAoExrUasluFiN0q3W5Z+EnZOKN3WVhPjJ7+Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaKxK6cZSGvyv+AqYhKNKB+yE/Ua5wwqo6JxNOSSsqwhCEqJPgdl7KEqOwEm/Mmd2
         lHMiqQzJzx/1rtpiNlvqXwkQ6D1gHbNFHq5n0G6er+PFsO0ZUuxter2WUm5qtk7gSb
         GjORhEp4fSy0k5a0lK/MzwZamyihDKcEVgnPdcluhv4KHAqWip0UkI54RC0q9iMKEw
         HU8jWvnSP5nhUELlQK/SGIlm+Lmz1+D4UQEFi6h4mK9llOSN/Ih8Mu+KYmhPqsxzLT
         4qwdABtmxSi6XVn+0fy/Cmsnr8z81YrN22U7E2DxZ3wVHnluIV7Cp0YWQJCsWxBn9U
         +iVl3hgEL7wzg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] nvmem: sunplus-ocotp: staticize sp_otp_v0
Date:   Mon, 21 Mar 2022 12:03:25 +0100
Message-Id: <20220321110326.44652-2-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220321110326.44652-1-krzk@kernel.org>
References: <20220321110326.44652-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "sp_otp_v0" file scope variable is not used outside, so make it
static to fix warning:

  drivers/nvmem/sunplus-ocotp.c:74:29: sparse:
    sparse: symbol 'sp_otp_v0' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/sunplus-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 2dc59c22eb55..c94134649714 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -71,7 +71,7 @@ struct sp_ocotp_data {
 	int size;
 };
 
-const struct sp_ocotp_data  sp_otp_v0 = {
+static const struct sp_ocotp_data sp_otp_v0 = {
 	.size = QAC628_OTP_SIZE,
 };
 
-- 
2.32.0

