Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9DECAAA2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 03:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiH2DIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Aug 2022 23:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH2DIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:08:31 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649963ECC8;
        Sun, 28 Aug 2022 20:08:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.68.216])
        by gnuweeb.org (Postfix) with ESMTPSA id 094AE80B11;
        Mon, 29 Aug 2022 03:07:58 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1661742481;
        bh=SJyjDYyBoXZYMkiEKyI9duAVBN/pZrSeFntJlaGszDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwekcET9EqL1L9NEGMfYp16jvfi3VpuSluLXOmVGq97uPtSRKy3fU3cZri2Jtec7J
         vIdhc+iLGIKrQtk+jFK0nxrvCaAQFIAEfQfROuaMSDZoILmlFfZH7TJXhHAcdcdsxQ
         kXtFJlICe4qCZXr4JOf/OkvxvYRdWfHQdcGvdzoKeo+UvPuNoWKJ3uhbNiG7hLrW6o
         krf14hOgI+on2FQAYzrPhhTDjTCeDk9uIGsR16QydCjRVOPh58DmoaulsoM1AFOV5+
         kHSY/IN/O8fO1ru+ph3J4savkPG7oyHoSlSzgTBfg6rMYuOXK4KZcS55AoaJ5x4rxd
         HFeM6k/AFAlUw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Caleb Sander <csander@purestorage.com>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH liburing v1 3/4] man: Alias `io_uring_enter2()` to `io_uring_enter()`
Date:   Mon, 29 Aug 2022 10:07:38 +0700
Message-Id: <20220829030521.3373516-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829030521.3373516-1-ammar.faizi@intel.com>
References: <20220829030521.3373516-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

We have a new function io_uring_enter2(), add the man page entry for it
by aliasing it to io_uring_enter(). This aliased man entry has already
explained it.

Cc: Caleb Sander <csander@purestorage.com>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 man/io_uring_enter2.2 | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 man/io_uring_enter2.2

diff --git a/man/io_uring_enter2.2 b/man/io_uring_enter2.2
new file mode 120000
index 0000000..5566c09
--- /dev/null
+++ b/man/io_uring_enter2.2
@@ -0,0 +1 @@
+io_uring_enter.2
\ No newline at end of file
-- 
Ammar Faizi

