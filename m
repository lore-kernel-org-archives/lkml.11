Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536AEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiDJQeE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiDJQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE2DEF8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z16so12579455pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yU+vBGEs0hJu5+rGTU3MHDinaz43KmLmKdOju9XgNQ=;
        b=IrwBWCFOVfmkafhQzlbBNdy6jswf7TD07xn6AsCFmU51FGERKrM4nobPty/LkSVph7
         e20/4b0QPR2whF3JKwD2XFt4Os7eCBMkJGG5nykgQkQ6bVlq1Dl0rk1cQwlWoB65sK0g
         WivTruq7jSW+LzBkXgSeUD3yWyMTVY/P9veqhqL/srJ2eMZST4cTpgwCTRuyvCi3TxAs
         vwzfAqmJ53HnmzL8CVjvHuvkuDySsgZrkvq32ODpH7my5Y+FPsPiqO4TUKM6KRdh95M6
         NOSNA6qq39W9hBbAOq7PJ/wnpC5B3fIuPqr8LknjK2NfIBCr08WA8ASZGrMQkL/SO71f
         vQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yU+vBGEs0hJu5+rGTU3MHDinaz43KmLmKdOju9XgNQ=;
        b=x7EWL7nL/DLbgmbJJzLA8nWvfBjNg5kXhTOjL/jDHffN72wsZECX9hvWxDZvXgfraW
         Gzk7I1w5CGLOEDLNo5SkoxL53j9/pswUfvWqafw/mzDNGO9RCoIajC5ve43fYEaKxykY
         SRQteue/AQ6eRZOiQtjACKO1Sv7pZ0x4Lhjc3gEOn/f68gLvrRgNhj9Cm2dsFDIlmRLC
         X99+CGXC0kL1pMzRBIaRSL+gTPADiWH5sTo2pU4CGdw44lduCgTWDXW54TCO0cwYQxUI
         Z/Bw6BQLoO+8W6kSpYKIHoTogKvCBTeiSeVxececRqik+S7V8PgS1gQoEdseLxral8tj
         3NPw==
X-Gm-Message-State: AOAM533cPidcH4iqcp/XPrm05oGU01h9KEYB5lmrTGb6T7EbtoRSx8NW
        U29jt98EZBPBafxiCfXHLYk=
X-Google-Smtp-Source: ABdhPJz67nU7sOqT5zNutVei3WjibcRCt21sJJ/szY6IhvvN9cNR0r+512gXZvi19wG+WCDC8Lp3rA==
X-Received: by 2002:a65:6a4c:0:b0:39c:f169:b54a with SMTP id o12-20020a656a4c000000b0039cf169b54amr11725706pgu.384.1649608309284;
        Sun, 10 Apr 2022 09:31:49 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:31:49 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 0/6] drop some unnecessary wrappers
Date:   Sun, 10 Apr 2022 22:01:11 +0530
Message-Id: <20220410163117.3964-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some unnecessary wrappers and update all the references
accordingly.
Tested on Comfast CF-WU810N RTL8188EUS wireless adapter.

Vihas Makwana (6):
  staging: r8188eu: drop unnecessary wrapper rtw_free_cmd_priv
  staging: r8188eu: drop unnecessary wrapper rtw_init_cmd_priv
  staging: r8188eu: drop unnecessary wrapper rtw_init_evt_priv
  staging: r8188eu: drop unnecessary wrapper rtw_dequeue_cmd
  staging: r8188eu: drop unnecessary wrapper rtw_init_mlme_priv
  staging: r8188eu: drop unnecessary wrapper rtw_free_mlme_priv

 drivers/staging/r8188eu/core/rtw_cmd.c     | 45 ++++------------------
 drivers/staging/r8188eu/core/rtw_mlme.c    | 16 +-------
 drivers/staging/r8188eu/include/rtw_cmd.h  |  8 ++--
 drivers/staging/r8188eu/include/rtw_mlme.h |  3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c  | 14 +++----
 5 files changed, 20 insertions(+), 66 deletions(-)

-- 
2.30.2

