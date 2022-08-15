Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C1C28B2B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbiHOU0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbiHOUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:19:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298679ECA;
        Mon, 15 Aug 2022 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB332B8105C;
        Mon, 15 Aug 2022 19:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9CC433D6;
        Mon, 15 Aug 2022 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590034;
        bh=YaFyEq5TNnM0erthFu+YMa+BtPUKxaeMZE5sVwUj5uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFWDe0AN35OYAJ4gawyCvW7ZSW+XkdNbcZfe2n+4nRrKwRGTiYb2doTrAbO0qwr5M
         kE7PB452JkO/2vnaORIDeAGxQc4jfSgjn9ufW+BfjtAdkQEOl9r6M0q5DxmS+T/FyK
         GXRyzjD/T0WEvTP/j6FxlHW50SMyYsZd5dfQyZJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 5.18 0099/1095] ksmbd: fix memory leak in smb2_handle_negotiate
Date:   Mon, 15 Aug 2022 19:51:38 +0200
Message-Id: <20220815180433.649914395@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit aa7253c2393f6dcd6a1468b0792f6da76edad917 upstream.

The allocated memory didn't free under an error
path in smb2_handle_negotiate().

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-17815
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1139,12 +1139,16 @@ int smb2_handle_negotiate(struct ksmbd_w
 			       status);
 			rsp->hdr.Status = status;
 			rc = -EINVAL;
+			kfree(conn->preauth_info);
+			conn->preauth_info = NULL;
 			goto err_out;
 		}
 
 		rc = init_smb3_11_server(conn);
 		if (rc < 0) {
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			kfree(conn->preauth_info);
+			conn->preauth_info = NULL;
 			goto err_out;
 		}
 


