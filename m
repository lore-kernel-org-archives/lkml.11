Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76808C00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 03:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiHHDgq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 23:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiHHDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:36:43 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 594715FAF
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:36:41 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2783ahgC007586;
        Mon, 8 Aug 2022 05:36:43 +0200
Date:   Mon, 8 Aug 2022 05:36:43 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "brookxu.cn@gmail.com" <brookxu.cn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Choose 5.10 LTS or 5.15 LTS
Message-ID: <20220808033643.GB7325@1wt.eu>
References: <61ecca29-2d01-af2d-3d18-62dad41c63b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ecca29-2d01-af2d-3d18-62dad41c63b4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:35:19AM +0800, brookxu.cn@gmail.com wrote:
> We want to choose an LTS kernel version to use for a few years. As we know,
> the 5.10 LTS has a 6 years maintenance period with the help of huawei. But
> the 5.15 LTS currently only has a two-year maintenance period, and it may
> reach EOL next year. It is currently unclear whether it will be extended.

It all depends on what level of effort you're willing to make:

- if you really want to just use and not participate at all (i.e. report
  issues, test pre-releases etc), 5.10 will be more suited.

- if you're willing to participate, you can start to encourage others to
  do so as well in order to convince Greg that he will not be alone in
  this tedious task and that it's worth extending 5.15.

- or if you're willing to invest a little bit of time but don't want to
  engage too far, you could also take the risk of going for 5.15, hoping
  that it will be extended, knowing that if it's not, it will be your
  job to deal with backports (which usually is a real pain and would
  justify giving back some help on official support instead).

> Coupled with the arrival of the 6.0 kernel, I am a little worried that the
> maintenance of 5.15 will be reduced. Does anyone have good suggestions,
> thank you.

That's just numbering, and should in no way affect maintenance of existing
code.

Hoping this helps,
Willy
