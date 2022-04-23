Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F3AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 02:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiDWChC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiDWCgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F29135657;
        Fri, 22 Apr 2022 19:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C36E5B8335C;
        Sat, 23 Apr 2022 02:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C2C385A4;
        Sat, 23 Apr 2022 02:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650681234;
        bh=t0ImcbWybH3sSsXr94ynvBKQK32TJrvfv99STsPv0rg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vLIW0nlNx9mM2dr+Vu/Luf0TZPUAgu4vGf55IuVSJ+ky1QD0X0fXYk8FJIAuHTmU+
         WWfIEaJQSQ/Siv9XBJ9xm1aQDZkJ5HylciOtPFF8A1OZpvWhCAyKRn0YWc9KFKaCgN
         pmSkfH91gX5jDyhW5QRGshqajGVyjfQuGwFCvSNtz/0n2xqfn1WcI+lYGqK/ZYUZPp
         duQ/5r72YJM+GARZeGr5vD86ZV14gP1ppPKYE03XHwE6vVGn/N9+aTIuKqZx2V6otg
         /TwhZgo8ZMt1ctpTSuRRbU/aPlYsLpBSVSsPzJr6vAYSeKJ6vsizr2rtPOVdhvlcqA
         qPJI3Ru3BqObw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220407151831.2371706-7-steve@sk2.org>
References: <20220407151831.2371706-1-steve@sk2.org> <20220407151831.2371706-7-steve@sk2.org>
Subject: Re: [PATCH v2 06/10] clk: si5341: use simple i2c probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>, Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Fri, 22 Apr 2022 19:33:51 -0700
User-Agent: alot/0.10
Message-Id: <20220423023354.849C2C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-04-07 08:18:27)
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next
