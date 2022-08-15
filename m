Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E1C28B2C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiHOVQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348017AbiHOVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444042E68D;
        Mon, 15 Aug 2022 12:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E6A60EF0;
        Mon, 15 Aug 2022 19:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4146C433C1;
        Mon, 15 Aug 2022 19:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591068;
        bh=791j+2hWy8TOd/D1gDSC01GR07M5nk56qoSUdhg5FAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXVzWNL9Z1DSyVDeQQTbVrCCsjYzHu1TeBW69fZhrDoePkwbnlWNjEyl3TuuDZrvI
         SBgWzB+bcPyrEXh8Ypkhr6Bdk9ezud6uJAD5kp21v5AUXQt+vOyZhERH7bhtxU0rmn
         D9ph9cyAqBcpiErmA72GVGJOpCXK2UfN6z14MH/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        John Stultz <jstultz@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0460/1095] selftests: timers: valid-adjtimex: build fix for newer toolchains
Date:   Mon, 15 Aug 2022 19:57:39 +0200
Message-Id: <20220815180448.625934164@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 9a162977d20436be5678a8e21a8e58eb4616d86a ]

Toolchains with an include file 'sys/timex.h' based on 3.18 will have a
'clock_adjtime' definition added, so it can't be static in the code:

valid-adjtimex.c:43:12: error: static declaration of ‘clock_adjtime’ follows non-static declaration

Fixes: e03a58c320e1 ("kselftests: timers: Add adjtimex SETOFFSET validity tests")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/timers/valid-adjtimex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 5397de708d3c..48b9a803235a 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -40,7 +40,7 @@
 #define ADJ_SETOFFSET 0x0100
 
 #include <sys/syscall.h>
-static int clock_adjtime(clockid_t id, struct timex *tx)
+int clock_adjtime(clockid_t id, struct timex *tx)
 {
 	return syscall(__NR_clock_adjtime, id, tx);
 }
-- 
2.35.1



