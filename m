Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B009FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jan 2022 11:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiAQLO3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jan 2022 06:14:29 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59005 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233906AbiAQLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:14:28 -0500
Received: from localhost.localdomain (ip5f5aeb79.dynamic.kabel-deutschland.de [95.90.235.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A7EE61EA1922;
        Mon, 17 Jan 2022 12:14:25 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vm: Fix typo in *harden*
Date:   Mon, 17 Jan 2022 12:13:37 +0100
Message-Id: <20220117111338.115455-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: df4e817b7108 ("mm: page table check")
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 Documentation/vm/page_table_check.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
index 81f521ff7ea7..1a09472f10a3 100644
--- a/Documentation/vm/page_table_check.rst
+++ b/Documentation/vm/page_table_check.rst
@@ -9,7 +9,7 @@ Page Table Check
 Introduction
 ============
 
-Page table check allows to hardern the kernel by ensuring that some types of
+Page table check allows to harden the kernel by ensuring that some types of
 the memory corruptions are prevented.
 
 Page table check performs extra verifications at the time when new pages become
-- 
2.34.1

