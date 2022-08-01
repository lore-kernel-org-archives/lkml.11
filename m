Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB10C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 12:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiHAMS3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiHAMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297E97F51D;
        Mon,  1 Aug 2022 04:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A916010C;
        Mon,  1 Aug 2022 11:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D7C433C1;
        Mon,  1 Aug 2022 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659355151;
        bh=o0GoZC8jqwAki4OA/myQhdnHoWr7JPzkZQ93pZ7RDjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llgvTUmeWUJdXjx6NUuikzZluxESnvVQDPwDuFKfnT8g/xx8OWxQLNH9kT2R0a5st
         pijhaeedT+cvaGJrF1GbtSp4DOgnEY2Ec+8n3XtjENfGDI3SshV0K2dK1aWBSJk3lC
         rBxM+xVcX0GhgbAPywYKCHlOnJezglXK5tk3Ri3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 81/88] tcp: Fix data-races around sysctl_tcp_workaround_signed_windows.
Date:   Mon,  1 Aug 2022 13:47:35 +0200
Message-Id: <20220801114141.695725172@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801114138.041018499@linuxfoundation.org>
References: <20220801114138.041018499@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 0f1e4d06591d0a7907c71f7b6d1c79f8a4de8098 ]

While reading sysctl_tcp_workaround_signed_windows, it can be changed
concurrently.  Thus, we need to add READ_ONCE() to its readers.

Fixes: 15d99e02baba ("[TCP]: sysctl to allow TCP window > 32767 sans wscale")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 66836b8bd46f..a7f0a1f0c2a3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -227,7 +227,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	 * which we interpret as a sign the remote TCP is not
 	 * misinterpreting the window field as a signed quantity.
 	 */
-	if (sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows)
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows))
 		(*rcv_wnd) = min(space, MAX_TCP_WINDOW);
 	else
 		(*rcv_wnd) = min_t(u32, space, U16_MAX);
@@ -282,7 +282,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 * scaled window.
 	 */
 	if (!tp->rx_opt.rcv_wscale &&
-	    sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows)
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows))
 		new_win = min(new_win, MAX_TCP_WINDOW);
 	else
 		new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
-- 
2.35.1



