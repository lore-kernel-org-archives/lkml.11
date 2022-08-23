Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98152C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiHWIJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiHWIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69856C765;
        Tue, 23 Aug 2022 01:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614376123D;
        Tue, 23 Aug 2022 08:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA593C433D6;
        Tue, 23 Aug 2022 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661241908;
        bh=XXnsT8YnvLr5n07bfMayojz6yEaBHQq9iwO02OlXMVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c48SkWsePC5SDFot3+abi7+NQtX1ZN2y8UGoRS51fM+FkBz4z7E0qBAS405TkVx5S
         Ih3sdvDRHgTieFYRnIDVhxkh6haOVpW4S5fHkWWpfbx/wP398vYhBQvDs42tdZVkJ9
         Ikx7UnhFFMjVfdMsnbxXs/R3rpO0jczXPZqJ65YQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.19 016/365] mmc: pxamci: Fix an error handling path in pxamci_probe()
Date:   Tue, 23 Aug 2022 09:58:37 +0200
Message-Id: <20220823080118.861640237@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 98d7c5e5792b8ce3e1352196dac7f404bb1b46ec upstream.

The commit in Fixes: has moved some code around without updating gotos to
the error handling path.

Update it now and release some resources if pxamci_of_init() fails.

Fixes: fa3a5115469c ("mmc: pxamci: call mmc_of_parse()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/6d75855ad4e2470e9ed99e0df21bc30f0c925a29.1658862932.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/pxamci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -648,7 +648,7 @@ static int pxamci_probe(struct platform_
 
 	ret = pxamci_of_init(pdev, mmc);
 	if (ret)
-		return ret;
+		goto out;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;


