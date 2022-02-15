Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0702C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 13:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiBONHb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:07:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiBONH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:07:28 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BCB0A41;
        Tue, 15 Feb 2022 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1644930438; x=1676466438;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=9btP8uEaJC0GxydzcBL9hGXrHqbmd82Gv2vpIfE35jI=;
  b=Yj9BoEQ7p0TtTkZUmp8Ptr/JOc0qaf8IrvBjPil7kwtSfEqj26/8yUvY
   RV11YKlvNYyWb+KQARYSeJ9VGU1rHTHpnobKWRqRtm45q2bc3csa7Wr8i
   36MtCDXKsNKo4NTIeXgX+a5zBJ5i29H8XsHgYcpmvpsQSSlc4jpbOqXKl
   Y=;
X-IronPort-AV: E=Sophos;i="5.88,370,1635206400"; 
   d="scan'208";a="992139479"
Subject: Re: [PATCH 1/4] EDAC: Fix calculation of returned address and next offset in
 edac_align_ptr()
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 15 Feb 2022 13:07:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id BE87141A63;
        Tue, 15 Feb 2022 13:07:03 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 15 Feb 2022 13:07:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 15 Feb 2022 13:07:01 +0000
Received: from [10.95.85.216] (10.95.85.216) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.28 via Frontend
 Transport; Tue, 15 Feb 2022 13:06:59 +0000
Message-ID: <6cbcf540-8f58-3b67-77e6-308b587695f7@amazon.com>
Date:   Tue, 15 Feb 2022 15:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ronenk@amazon.com>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-2-farbere@amazon.com> <YfALFy7LGGIOS2Fv@zn.tnic>
 <9bd8f3c5-2281-8235-9eac-d2c371245a54@amazon.com> <YgudxpqAlyQ5UqlF@zn.tnic>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YgudxpqAlyQ5UqlF@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/2022 2:34 PM, Borislav Petkov wrote:
> Just to make sure I understand you correctly: you're talking about some
> internal version of al_mc_edac - not what's upstream?

Yes, I'm talking about an internal version that wasn't up-streamed yet.

--
Regards, Eliav

