Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794BCCA47B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiGEMMb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiGEMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:07:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81D1929F;
        Tue,  5 Jul 2022 05:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86F30B817CE;
        Tue,  5 Jul 2022 12:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEAC341C7;
        Tue,  5 Jul 2022 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657022800;
        bh=tBysG5slX1gmz22KZWHuypWFecdUfpb8HUCfdcMG+6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAqnv1SKRFGIqljoCPUCNF9mSMTMemOtI3BD+oCzS7BVBg4gXUYbpPmjEdSuk15mA
         LKd7KauCsVHqYg/dFFGuOgWrkP1Esy9MH1q2ZR66JSd0MEyAe9Y9vMpXsB1fPkYxS7
         oLiRmmkYX9VdLYaVMRnhg5J0ubo69Rj0fbULwnEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, willemb@google.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 15/84] selftests/net: pass ipv6_args to udpgso_benchs IPv6 TCP test
Date:   Tue,  5 Jul 2022 13:57:38 +0200
Message-Id: <20220705115615.772140911@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115615.323395630@linuxfoundation.org>
References: <20220705115615.323395630@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dimitris Michailidis <d.michailidis@fungible.com>

commit b968080808f7f28b89aa495b7402ba48eb17ee93 upstream.

udpgso_bench.sh has been running its IPv6 TCP test with IPv4 arguments
since its initial conmit. Looks like a typo.

Fixes: 3a687bef148d ("selftests: udp gso benchmark")
Cc: willemb@google.com
Signed-off-by: Dimitris Michailidis <dmichail@fungible.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20220623000234.61774-1-dmichail@fungible.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/udpgso_bench.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -120,7 +120,7 @@ run_all() {
 	run_udp "${ipv4_args}"
 
 	echo "ipv6"
-	run_tcp "${ipv4_args}"
+	run_tcp "${ipv6_args}"
 	run_udp "${ipv6_args}"
 }
 


