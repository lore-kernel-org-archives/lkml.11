Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE99C47085
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392455AbiDEWJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349347AbiDEJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FACDBC;
        Tue,  5 Apr 2022 02:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08CA5B817D3;
        Tue,  5 Apr 2022 09:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBD5C385A2;
        Tue,  5 Apr 2022 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649151856;
        bh=98aCFofgFx1i2qmaGNmZ2Ir40iIRhlyna9C5ZXP/Y2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zxKVXEiH0Nj3a108bCEZ6cymdOupquHXyny9iUU3ZuBgK1Md4ZSyu398PNtRZ5ho
         5Ao3mC2GoEAvs5NRazgQNhTULPr4pZqCqKmQCQHCeI3j8ENFyPcDOL1MR9RuX1pZe9
         HSOdDBb+9/TL9KXh/l7jAuCIjbruQEnzz0NQRKoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 565/913] selftests/bpf/test_lirc_mode2.sh: Exit with proper code
Date:   Tue,  5 Apr 2022 09:27:07 +0200
Message-Id: <20220405070356.780493269@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit ec80906b0fbd7be11e3e960813b977b1ffe5f8fe ]

When test_lirc_mode2_user exec failed, the test report failed but still
exit with 0. Fix it by exiting with an error code.

Another issue is for the LIRCDEV checking. With bash -n, we need to quote
the variable, or it will always be true. So if test_lirc_mode2_user was
not run, just exit with skip code.

Fixes: 6bdd533cee9a ("bpf: add selftest for lirc_mode2 type program")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20220321024149.157861-1-liuhangbin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_lirc_mode2.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lirc_mode2.sh b/tools/testing/selftests/bpf/test_lirc_mode2.sh
index ec4e15948e40..5252b91f48a1 100755
--- a/tools/testing/selftests/bpf/test_lirc_mode2.sh
+++ b/tools/testing/selftests/bpf/test_lirc_mode2.sh
@@ -3,6 +3,7 @@
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+ret=$ksft_skip
 
 msg="skip all tests:"
 if [ $UID != 0 ]; then
@@ -25,7 +26,7 @@ do
 	fi
 done
 
-if [ -n $LIRCDEV ];
+if [ -n "$LIRCDEV" ];
 then
 	TYPE=lirc_mode2
 	./test_lirc_mode2_user $LIRCDEV $INPUTDEV
@@ -36,3 +37,5 @@ then
 		echo -e ${GREEN}"PASS: $TYPE"${NC}
 	fi
 fi
+
+exit $ret
-- 
2.34.1



