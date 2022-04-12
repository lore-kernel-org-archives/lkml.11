Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB51C47085
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354636AbiDLIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353821AbiDLHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE8B849;
        Tue, 12 Apr 2022 00:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F570B81B4D;
        Tue, 12 Apr 2022 07:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94365C385A6;
        Tue, 12 Apr 2022 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747085;
        bh=sC+yelsbh94fJQss7tqpXVH0tAA6PB+cx7LgaWENbnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byXVzf7f1/wBmsuBv42TRV+X7fV/3IwH6B8rd5iQiL9KIxPIi4xogz6+sCiN+QYLr
         5YUp9tsSn3R96npsBl6dmZJX0G7qWkBG/ZSSHRSVfibCh6V1HveuETCbbfUzJYc5d8
         eewUkppLnF3PqFZovhmDGCcRZNSH/xcGqK/WpWhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Gardner <tim.gardner@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Alok Prasad <palok@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>
Subject: [PATCH 5.16 237/285] qed: fix ethtool register dump
Date:   Tue, 12 Apr 2022 08:31:34 +0200
Message-Id: <20220412062950.503604405@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062943.670770901@linuxfoundation.org>
References: <20220412062943.670770901@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

commit 20921c0c86092b4082c91bd7c88305da74e5520b upstream.

To fix a coverity complain, commit d5ac07dfbd2b
("qed: Initialize debug string array") removed "sw-platform"
(one of the common global parameters) from the dump as this
was used in the dump with an uninitialized string, however
it did not reduce the number of common global parameters
which caused the incorrect (unable to parse) register dump

this patch fixes it with reducing NUM_COMMON_GLOBAL_PARAMS
bye one.

Cc: stable@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>
Fixes: d5ac07dfbd2b ("qed: Initialize debug string array")
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Manish Chopra <manishc@marvell.com>
Reviewed-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -489,7 +489,7 @@ struct split_type_defs {
 
 #define STATIC_DEBUG_LINE_DWORDS	9
 
-#define NUM_COMMON_GLOBAL_PARAMS	11
+#define NUM_COMMON_GLOBAL_PARAMS	10
 
 #define MAX_RECURSION_DEPTH		10
 


