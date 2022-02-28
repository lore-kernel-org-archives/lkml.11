Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiB1Rv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiB1Rpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:45:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BB43AEE;
        Mon, 28 Feb 2022 09:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C3E61357;
        Mon, 28 Feb 2022 17:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D186C340E7;
        Mon, 28 Feb 2022 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069869;
        bh=re8j0cwAUKK6PJWb56yhqhBnF9YWtkD/UuOaJsCwDGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSgipmXNGywZf1MPhAPS65bMk+kZMaCvRlnyVDzIWHQtHwlaJIZHDuwBChfmDH/U0
         lFyUTShefWOqTVlwePJ05LebPIzAOnphqJTKgcN4YLWgPscbjXeWkfIGQmY7RXfMP4
         /aOorfgZxxCsVsJo2+rsXDWdkD2u55pTLclQQxho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 040/139] selftests: mptcp: be more conservative with cookie MPJ limits
Date:   Mon, 28 Feb 2022 18:23:34 +0100
Message-Id: <20220228172351.945893181@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172347.614588246@linuxfoundation.org>
References: <20220228172347.614588246@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit e35f885b357d47e04380a2056d1b2cc3e6f4f24b upstream.

Since commit 2843ff6f36db ("mptcp: remote addresses fullmesh"), an
MPTCP client can attempt creating multiple MPJ subflow simultaneusly.

In such scenario the server, when syncookies are enabled, could end-up
accepting incoming MPJ syn even above the configured subflow limit, as
the such limit can be enforced in a reliable way only after the subflow
creation. In case of syncookie, only after the 3rd ack reception.

As a consequence the related self-tests case sporadically fails, as it
verify that the server always accept the expected number of MPJ syn.

Address the issues relaxing the MPJ syn number constrain. Note that the
check on the accepted number of MPJ 3rd ack still remains intact.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -624,6 +624,7 @@ chk_join_nr()
 	local ack_nr=$4
 	local count
 	local dump_stats
+	local with_cookie
 
 	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
@@ -637,12 +638,20 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
+	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
-		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-		ret=1
-		dump_stats=1
+		# simult connections exceeding the limit with cookie enabled could go up to
+		# synack validation as the conn limit can be enforced reliably only after
+		# the subflow creation
+		if [ "$with_cookie" = 2 ] && [ "$count" -gt "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
+			echo -n "[ ok ]"
+		else
+			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
+			ret=1
+			dump_stats=1
+		fi
 	else
 		echo -n "[ ok ]"
 	fi


