Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 00:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiCRACe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCRACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59117B0CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 831156145C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A26C340E9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:01:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cVMMhBG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647561668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uwfZ7u+3OUKgL2+/D4viVTjD3L/cggI1cxQSeUBNcqU=;
        b=cVMMhBG+5LNG2ftoPOOeqCBW/p9iLQF9KuH+Z3Q16racCbvb8KnLC6zClLz4tlcx1sTqI0
        Xnzw1NCvs5M5M3vkeKQC+EokVgGAp7qE75fNJw+tA6nEKR+8+PTJ3ipCSnqYOYoVf47SO6
        WifSYDymXXT2Pm2nZbumlZlaH37lTQc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ffec849c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 18 Mar 2022 00:01:08 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e592e700acso75959207b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:01:08 -0700 (PDT)
X-Gm-Message-State: AOAM530WQhYksQWOKBwqvOb/8hLkJbf3elL2fWEoGYEwjc1aH9JbdVGS
        yufLgXYVbrFpSp1nzWhpfiT5EC23Hb/51CBzZd4=
X-Google-Smtp-Source: ABdhPJwVWHzVA9/oVu+v9YAWochheu96zGoBfiL9ysWNAsJYRohB0h4ZM53akO0WYjRYXdttDZpJBVwPfJnO85MPGHc=
X-Received: by 2002:a0d:c681:0:b0:2db:9ffe:1f00 with SMTP id
 i123-20020a0dc681000000b002db9ffe1f00mr9121007ywd.100.1647561668026; Thu, 17
 Mar 2022 17:01:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Mar 2022 18:00:57 -0600
X-Gmail-Original-Message-ID: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
Message-ID: <CAHmME9q55ifnzxE9zLuLT=Hgjv=qcvjU-O-c8G=_o_V_O+p44Q@mail.gmail.com>
Subject: Large post detailing recent Linux RNG improvements
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

Thought I should mention here that I've written up the various RNG
things I've been working on for 5.17 & 5.18 here:
https://www.zx2c4.com/projects/linux-rng-5.17-5.18/ .

Feel free to discuss on list here if you'd like, or if you see
something you don't like, I'll happily review patches!

Regards,
Jason
