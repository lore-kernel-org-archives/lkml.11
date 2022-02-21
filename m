Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D3AC4167E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352742AbiBUJ4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:56:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352883AbiBUJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762E326ACB;
        Mon, 21 Feb 2022 01:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1131A60F54;
        Mon, 21 Feb 2022 09:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE2DC340E9;
        Mon, 21 Feb 2022 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435252;
        bh=bJzUXvWr0rPpDE5ZvA4GkAP0B1xIa53SNskKhLA6iCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5LEHg1DfqKlXH7VnHvK8TnAjNMmXTL94A9/utKDs/Cbbv9/FsROTWmt7D3fV75VN
         y4on/O7jRygSDpYedL9BgWTxsZdow21o9n3wAojD8FAdgnh1E8qpMxWN7/8KXu3jdY
         zZbIzGsyAN1NZ2bmMmAPg+YsqWmSsQ5xJN+T93C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.16 098/227] selftests: netfilter: fix exit value for nft_concat_range
Date:   Mon, 21 Feb 2022 09:48:37 +0100
Message-Id: <20220221084938.140106516@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit 2e71ec1a725a794a16e3862791ed43fe5ba6a06b upstream.

When the nft_concat_range test failed, it exit 1 in the code
specifically.

But when part of, or all of the test passed, it will failed the
[ ${passed} -eq 0 ] check and thus exit with 1, which is the same
exit value with failure result. Fix it by exit 0 when passed is not 0.

Fixes: 611973c1e06f ("selftests: netfilter: Introduce tests for sets with range concatenation")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/netfilter/nft_concat_range.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/netfilter/nft_concat_range.sh
+++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
@@ -1601,4 +1601,4 @@ for name in ${TESTS}; do
 	done
 done
 
-[ ${passed} -eq 0 ] && exit ${KSELFTEST_SKIP}
+[ ${passed} -eq 0 ] && exit ${KSELFTEST_SKIP} || exit 0


