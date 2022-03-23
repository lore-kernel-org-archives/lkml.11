Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242163AbiCWHT4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiCWHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:19:51 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D1B72E12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:18:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22N7ICB9014462;
        Wed, 23 Mar 2022 08:18:12 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 0/2] nolibc: fix two build issues at -O0
Date:   Wed, 23 Mar 2022 08:18:05 +0100
Message-Id: <20220323071807.14413-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

please find in this series two build fixes to apply on top of the series
you've already queued:
 - gcc errors at -O0 because it doesn't eliminate non-inline code and
   keeps the reference to the external "environ" from getenv()
 - clang fails at -O0 because __builtin_strlen() calls strlen()

I don't care about optimizing at -O0 by definition but at least it should
build and work correctly! I've verified that rcutorture still runs.

Thanks!
Willy

---
Willy Tarreau (2):
  tools/nolibc/string: do not use __builtin_strlen() at -O0
  tools/nolibc/stdlib: only reference the external environ when inlined

 tools/include/nolibc/stdlib.h | 22 +++++++++++++++-------
 tools/include/nolibc/string.h | 11 ++++++++++-
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.35.1

