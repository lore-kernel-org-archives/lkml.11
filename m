Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B090C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 02:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiDWCgi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 22:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDWCge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:36:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF06813696A;
        Fri, 22 Apr 2022 19:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB718B8335C;
        Sat, 23 Apr 2022 02:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68236C385A4;
        Sat, 23 Apr 2022 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681217;
        bh=mbEVT6t/cWzFMSJiIXlmt+fzM5JhUYYMQJA5ktcaLL0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dtM1wt3+fzoZhfAO348qfQoU0IO7Z3mJl2vpx0Vx2dyy590KciN07uFWQMFvwBJ6e
         nwPrmOyQo8T4wxei6bubtx7P585Ib05QVDdzawZbRME5ciGaLJS2AE1m+A71Q8IObW
         xpCa69/h3L1Mq8xQe7zf9GKkt0BurvL46J1IyAXzcCC7lAlZyVAz4ZGUyVvuiOVu8c
         3pm3JYf0N7Omk+/ePcNTc2XleGsgj1Fl8zvu8jxXSsiYpZRpdSvRUvLM6ZkqfotDle
         t4t77z4323rzpN64BgPyrmuhZJGFSVYt+xG/PHwdG7CM/TqdDFleBORn4vdq1ZWQWM
         Wekqwrii86fiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-6-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-6-steve@sk2.org>
Subject: Re: [PATCH v2 05/10] clk: si514: use simple i2c probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:33:34 -0700
User-Agent: alot/0.10
Message-Id: <20220423023337.68236C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:26)
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
