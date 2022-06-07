Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381329AbiFHBkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385443AbiFGWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:21:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6EB26A917;
        Tue,  7 Jun 2022 12:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF093B823D0;
        Tue,  7 Jun 2022 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428DAC385A2;
        Tue,  7 Jun 2022 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629716;
        bh=7sLA/FhS46xZIY8jbEiSKlbZkQ/X83iNGhrfEs3mqlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1Se6G2rUupiH7hwQfxH/VqRkaG8b1rXurrxffj1MlmmC0MalKnKzWxvCQzwyopt7
         z1f1KESoEv/8BExx4xif1l1z31ROxTvWtHxkLXu+ncKZhOsMI+nZiVvlr7EbWJhMQr
         onM3EuI7R3ThW3FArbOpqHreOjb5dFWMyIUYlFug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 5.18 764/879] dlm: uninitialized variable on error in dlm_listen_for_all()
Date:   Tue,  7 Jun 2022 19:04:42 +0200
Message-Id: <20220607165025.040146496@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 1f4f10845e14690b02410de50d9ea9684625a4ae upstream.

The "sock" variable is not initialized on this error path.

Cc: stable@vger.kernel.org
Fixes: 2dc6b1158c28 ("fs: dlm: introduce generic listen")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/lowcomms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1789,7 +1789,7 @@ static int dlm_listen_for_all(void)
 				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0) {
 		log_print("Can't create comms socket: %d", result);
-		goto out;
+		return result;
 	}
 
 	sock_set_mark(sock->sk, dlm_config.ci_mark);


