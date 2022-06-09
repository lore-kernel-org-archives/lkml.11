Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 01:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiFIBas (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 21:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiFIBan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:30:43 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D534A2347DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:30:38 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 9 Jun 2022 10:30:36 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 9 Jun 2022 10:30:36 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     peterz@infradead.org, jpoimboe@redhat.com, bp@suse.de
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [REPORT] RESERVE_BRK() doesn't work for some cases
Date:   Thu,  9 Jun 2022 10:30:51 +0900
Message-Id: <1654738251-23522-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a1e2c031ec3 "x86/mm: Simplify RESERVE_BRK()" changed the behavior
by compiler and assembler.

Some strings obtained just by __stringify() cannot be interpreted by
some assemblers.

It might need to allow to put input for size within inline asm.

	Byungchul
