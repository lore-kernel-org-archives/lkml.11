Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CDCC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiFWQxP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiFWQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD41CFD7;
        Thu, 23 Jun 2022 09:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE0961F99;
        Thu, 23 Jun 2022 16:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC00C3411B;
        Thu, 23 Jun 2022 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656003094;
        bh=k/0LJkN2/FgEcWubVtK4K0/TeNEztiXv555kEZbY2+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVL75FwfLduXIHvg34PUzjso0jsnzdENOxQyu34joON+qgciXwb7tJ75rqF1EDl4R
         Dug/uVLXPehDPIW7HZNTtY1vlg/KjaAqnVJq1cM5E4at3QfotPRA6jjl7p4qWB8exC
         hch53NPIBDDJrr8OXQYcFgfmzM4eouPfu50NFUFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4.9 087/264] random: harmonize "crng init done" messages
Date:   Thu, 23 Jun 2022 18:41:20 +0200
Message-Id: <20220623164346.530644296@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623164344.053938039@linuxfoundation.org>
References: <20220623164344.053938039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 161212c7fd1d9069b232785c75492e50941e2ea8 upstream.

We print out "crng init done" for !TRUST_CPU, so we should also print
out the same for TRUST_CPU.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -833,7 +833,7 @@ static void __init crng_initialize_prima
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
-		pr_notice("crng done (trusting CPU's manufacturer)\n");
+		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }


