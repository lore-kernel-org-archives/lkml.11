Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39057ECAAD2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiIAXRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiIAXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:16:50 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3739AFA9;
        Thu,  1 Sep 2022 16:16:49 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id ADF5E2B8;
        Thu,  1 Sep 2022 23:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ADF5E2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662074209; bh=pjEqGsC3o1cCyVpcxwjXhbptLW8M3DxLII6MXHLKxx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HttwhfoNd2RBCMXJyH3N5bOHMY8PiWeXU1xreO7WiF/30gPdnyEx/tMdeurqK1kWx
         URVJCAicwSKYhN2RBXjmNJn7Xll1exANcYBIYJVF80j1nkolfEc9zgFuGs+T7S/Jhy
         9xnW25hwAumA4FN7OeK/WtGFyo06HW2O8JdFnpbPeX7bwj31SoMmZRM1Q8NdG5H2zc
         yCmWGjoVfUUaNjK62cPaWrRueB/IDSOkdr02SdUrHUoDR20GVAxtwAkP2OCKO9ESj6
         r0tCQm8pgiigvhk1azYvKCuDnQcchdHUo63veJLaT2E8rY4EHW0gREcFblahCHV1ov
         T1K6B/dntzGlQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/4] docs: reconfigure the HTML left column
Date:   Thu,  1 Sep 2022 17:16:31 -0600
Message-Id: <20220901231632.518583-4-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901231632.518583-1-corbet@lwn.net>
References: <20220901231632.518583-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the html_sidebars directive to get a more useful set of links in the
left column.

Unfortunately, this is a no-op with the default RTD theme, but others
observe it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 78dd6d1e7b88..22c9d4df1967 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -370,7 +370,8 @@ html_static_path = ['sphinx-static']
 html_use_smartypants = False
 
 # Custom sidebar templates, maps document names to template names.
-#html_sidebars = {}
+# Note that the RTD theme ignores this
+html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
 # Additional templates that should be rendered to pages, maps page names to
 # template names.
-- 
2.37.2

