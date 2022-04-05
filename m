Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1BC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353372AbiDEVFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354383AbiDEKOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:14:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198846F4AE;
        Tue,  5 Apr 2022 02:59:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3D1B81C86;
        Tue,  5 Apr 2022 09:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10271C385A2;
        Tue,  5 Apr 2022 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649152783;
        bh=WZ5lqIiERkhZAxCxhfRzo1GoFdYeuXgZNAeBjIF+Bag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zh5wFgAN2ZPKAzqcB6mFrI6ylYv/YEbDt+XcqZsBclZJULsyNLzHtSfUUWkf29tH+
         2jwFhhz4dgBlM6F3qzr89MC1Q9zu150Xq6aH5GRTx5ujzQbQG+2j7wBU+pwhy25Gxu
         2IBCZ7Fpofe0EXY47cx1Jv4KrUPkyOyaRKGlJidI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.15 900/913] torture: Make torture.sh help message match reality
Date:   Tue,  5 Apr 2022 09:32:42 +0200
Message-Id: <20220405070406.797349971@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

commit f233673cd32a048f2eed69e56b61174c33fb740b upstream.

This commit fixes a couple of typos: s/--doall/--do-all/ and
s/--doallmodconfig/--do-allmodconfig/.

[ paulmck: Add Fixes: supplied by Paul Menzel. ]

Fixes: a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -71,8 +71,8 @@ usage () {
 	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
-	echo "       --doall"
-	echo "       --doallmodconfig / --do-no-allmodconfig"
+	echo "       --do-all"
+	echo "       --do-allmodconfig / --do-no-allmodconfig"
 	echo "       --do-clocksourcewd / --do-no-clocksourcewd"
 	echo "       --do-kasan / --do-no-kasan"
 	echo "       --do-kcsan / --do-no-kcsan"


