Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE081C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385711AbiDEMia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiDEJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:02:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4CCFD03;
        Tue,  5 Apr 2022 01:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78401614E4;
        Tue,  5 Apr 2022 08:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87063C385A1;
        Tue,  5 Apr 2022 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148870;
        bh=61JOj3rc2LxFRa0F8Npl5jgFEtUFrS1lDJOqF8od3/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtQjK4v7hi3gb1T2FcyVtPHk/5xGpQe+NnPRhnB+Tf4U+DW1EYwWEoTT0flWIDlc6
         JKBtdEA9KWUjOlyC7GLemJDBKCmQfXSkkvtvvRarI4+11bWdyamotPksnehGMuBeYI
         Etb53/VK3UwFKzuM0vqsNbmaSVuwbBOYnRbs3pBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bracht Laumann Jespersen <t@laumann.xyz>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0473/1017] scripts/dtc: Call pkg-config POSIXly correct
Date:   Tue,  5 Apr 2022 09:23:06 +0200
Message-Id: <20220405070408.339016025@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bracht Laumann Jespersen <t@laumann.xyz>

[ Upstream commit a8b309ce9760943486e0585285e0125588a31650 ]

Running with POSIXLY_CORRECT=1 in the environment the scripts/dtc build
fails, because pkg-config doesn't output anything when the flags come
after the arguments.

Fixes: 067c650c456e ("dtc: Use pkg-config to locate libyaml")
Signed-off-by: Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220131112028.7907-1-t@laumann.xyz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/dtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 95aaf7431bff..1cba78e1dce6 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -29,7 +29,7 @@ dtc-objs	+= yamltree.o
 # To include <yaml.h> installed in a non-default path
 HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
 # To link libyaml installed in a non-default path
-HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
+HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
 endif
 
 # Generated files need one more search path to include headers in source tree
-- 
2.34.1



