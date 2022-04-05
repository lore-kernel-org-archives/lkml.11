Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C319C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiDELxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244850AbiDEIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615122BCE;
        Tue,  5 Apr 2022 01:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC113CE1C38;
        Tue,  5 Apr 2022 08:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA0C385A0;
        Tue,  5 Apr 2022 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148285;
        bh=vWQgRScnhf+N5V5xDuuUX80jMIdX6VFkf7+6IpBtfaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmgJdSOgJRi6t9MO0CDjyrUzjQLSzFrfRdmSYrFLnMO0SNV/OrNjndezXCHSyLQ5Y
         /s4S1csE07IDhJ7RA8XvSciYAjfTi6wNQFEDQVR6/iVzg5lYWFlETNjHyBYJ6pMsoR
         2+1nAOi5sLzD7OZPlJJ24WGM5S2O6Fmckxu/1LIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0264/1017] perf/core: Fix address filter parser for multiple filters
Date:   Tue,  5 Apr 2022 09:19:37 +0200
Message-Id: <20220405070402.100094453@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit d680ff24e9e14444c63945b43a37ede7cd6958f9 ]

Reset appropriate variables in the parser loop between parsing separate
filters, so that they do not interfere with parsing the next filter.

Fixes: 375637bc524952 ("perf/core: Introduce address range filtering")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-4-adrian.hunter@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e4a43d475ba6..a0e196f973b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10560,8 +10560,11 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			}
 
 			/* ready to consume more filters */
+			kfree(filename);
+			filename = NULL;
 			state = IF_STATE_ACTION;
 			filter = NULL;
+			kernel = 0;
 		}
 	}
 
-- 
2.34.1



